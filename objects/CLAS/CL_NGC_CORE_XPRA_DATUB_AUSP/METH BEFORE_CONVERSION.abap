METHOD before_conversion.

  DATA:
    lv_exists    TYPE i.

  " Ensure only privileged user are allowed to manually start the data conversion.
  rv_exit = cl_ngc_core_data_conv=>check_authority( ).

  IF ( rv_exit EQ abap_false AND iv_rework EQ abap_false ).

    " Skip execution if no conversion relevant data in this system (optional).
    " Avoid use of COUNT(*) unless really necessary.
    IF iv_client IS INITIAL.
      SELECT SINGLE 1 INTO @lv_exists FROM ausp CLIENT SPECIFIED WHERE datub = '00000000'.
    ELSE.
      SELECT SINGLE 1 INTO @lv_exists FROM ausp CLIENT SPECIFIED WHERE mandt = @iv_client AND datub = '00000000'.
    ENDIF.

    IF lv_exists NE 1.
      MESSAGE i033(upgba) WITH 'No data relevant for conversion found' 'in this system' INTO cl_upgba_logger=>mv_logmsg.
      cl_upgba_logger=>log->trace_single( ).
      cl_upgba_logger=>log->close( ).
      rv_exit = abap_true.
    ENDIF.

  ENDIF.

ENDMETHOD.