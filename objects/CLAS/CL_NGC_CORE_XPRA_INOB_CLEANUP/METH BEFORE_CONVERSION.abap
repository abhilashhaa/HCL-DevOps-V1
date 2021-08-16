METHOD before_conversion.

  DATA:
    lv_exists TYPE i.

  " Ensure only privileged user are allowed to manually start the data conversion.
  TEST-SEAM auth_check_seam.
    rv_exit = cl_ngc_core_data_conv=>check_authority( ).
  END-TEST-SEAM.

  IF rv_exit EQ abap_false.
    " First we have to set up our views.
    IF me->create_views( ) EQ abap_true.
      " Skip execution if no conversion relevant data in this system (optional).
      " Avoid use of COUNT(*) unless really necessary.
      TEST-SEAM exists_seam.
        SELECT SINGLE 1 INTO @lv_exists FROM (mv_inconinob_name) "#EC CI_DYNTAB
          CLIENT SPECIFIED WHERE mandt = @mv_client.       "#EC CI_CLIENT
      END-TEST-SEAM.

      IF lv_exists NE 1.
        MESSAGE i034(upgba) WITH 'No data relevant for conversion found' 'in this system. Client:' mv_client INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
        cl_upgba_logger=>log->trace_single( ).
        me->delete_views( ).
        rv_exit = abap_true.
        RETURN.
      ENDIF.
    ELSE.
      rv_exit = abap_true.
    ENDIF.
  ENDIF.

ENDMETHOD.