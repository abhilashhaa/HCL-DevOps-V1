METHOD before_conversion.

  DATA:
    lv_exists TYPE i.

  " Ensure only privileged user are allowed to manually start the data conversion.
  rv_exit = cl_ngc_core_data_conv=>check_authority( ).

  IF rv_exit EQ abap_false.
    " First we have to set up our views.
    IF me->create_views( ) EQ abap_true.
      IF mv_rework EQ abap_false. " In the rework case we need the UPDATE_REDUN!
        " Skip execution if no conversion relevant data in this system (optional).
        " Avoid use of COUNT(*) unless really necessary.
        SELECT SINGLE 1 INTO @lv_exists FROM (gv_refbou_name). "#EC CI_DYNTAB

        IF lv_exists NE 1.
          MESSAGE i034(upgba) WITH 'No data relevant for conversion found' 'in this system. Client:' sy-mandt INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
          cl_upgba_logger=>log->trace_single( ).

          me->delete_views( ).

          cl_upgba_logger=>log->close( ).
          rv_exit = abap_true.
          RETURN.
        ENDIF.
      ENDIF.
      me->build_clstype_ech_itab( ).
    ELSE.
      rv_exit = abap_true.
    ENDIF.
  ENDIF.

ENDMETHOD.