  METHOD check_timestamp.

    DATA: lv_ts TYPE timestamp.

    IF sy-subrc = 0 AND iv_date IS NOT INITIAL AND iv_time IS NOT INITIAL.
      cl_abap_tstmp=>systemtstmp_syst2utc(
        EXPORTING syst_date = iv_date
                  syst_time = iv_time
        IMPORTING utc_tstmp = lv_ts ).
      IF lv_ts < iv_timestamp.
        rv_changed = abap_false. " Unchanged
      ELSE.
        rv_changed = abap_true.
      ENDIF.
    ELSE. " Not found? => changed
      rv_changed = abap_true.
    ENDIF.

  ENDMETHOD.