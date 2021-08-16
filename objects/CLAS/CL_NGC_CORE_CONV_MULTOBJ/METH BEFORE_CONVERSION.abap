METHOD before_conversion.

  DATA:
    lv_exists    TYPE i.

  " Only Cloud is allowed.
  IF cl_cos_utilities=>is_cloud( ) = abap_true.
    rv_exit = abap_false.
  ELSE.
    MESSAGE e034(upgba) WITH 'This conversion report can be run' 'only in Cloud environment!' 'On-premise is not supported.' INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).
    rv_exit = abap_true.
  ENDIF.

  " Ensure only privileged user are allowed to manually start the data conversion.
  IF ( rv_exit EQ abap_false ).
    rv_exit = cl_ngc_core_data_conv=>check_authority( ).
  ENDIF.

  IF ( rv_exit EQ abap_false ).
    IF mv_class_type EQ '230'.
      MESSAGE e033(upgba) WITH 'Wrong parameter: Class Type=230!' 'Class Type 230 must NOT be converted!' INTO cl_upgba_logger=>mv_logmsg.
      cl_upgba_logger=>log->trace_single( ).
      rv_exit = abap_true.
    ELSE.
      " First we have to set up our views.
      IF me->create_views( ) EQ abap_true.
        " We need TCLA even when there is no relevant data to convert, because of MULTOBJ flags
        me->build_tcla_cache( ).

        " Skip execution if no conversion relevant data in this system (optional).
        " Avoid use of COUNT(*) unless really necessary.
        SELECT SINGLE 1 INTO @lv_exists FROM (mv_kssku_name).

        IF lv_exists NE 1.
          MESSAGE i034(upgba) WITH 'No data relevant for conversion found' 'in this system. Client:' sy-mandt INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( ).

          " We MUST update MULTOBJ flags even if there is no classification data yet
          TRY.
            me->prepare_customizing( ).
            me->update_multobj( ).
          CATCH cx_data_conv_error INTO DATA(lx_data_conv_error).
            cl_upgba_logger=>log->error( ix_root = lx_data_conv_error  iv_incl_srcpos = abap_true ).
          ENDTRY.

          me->delete_views( ).
          rv_exit = abap_true.
          RETURN.
        ENDIF.
      ELSE.
        rv_exit = abap_true.
      ENDIF.
    ENDIF.

  ENDIF.

ENDMETHOD.