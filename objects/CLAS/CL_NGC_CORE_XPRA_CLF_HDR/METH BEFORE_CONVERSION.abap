METHOD BEFORE_CONVERSION.

  DATA:
    lv_exists_cs TYPE boole_d,
    lv_exists_cm TYPE boole_d,
    lv_exists_s  TYPE boole_d,
    lv_exists_m  TYPE boole_d,
    lv_exists_k  TYPE boole_d.

  " Ensure only privileged user are allowed to manually start the data conversion.
  TEST-SEAM auth_check_seam.
    rv_exit = cl_ngc_core_data_conv=>check_authority( ).
  END-TEST-SEAM.

  IF rv_exit EQ abap_false.
    " First we have to set up our views.
    IF cl_ngc_core_xpra_clf_hdr=>create_views( ) EQ abap_true.
      " Skip execution if no conversion relevant data in this system (optional).
      " Avoid use of COUNT(*) unless really necessary.
      IF iv_client IS INITIAL.
        TEST-SEAM exists_1_seam.
          SELECT SINGLE @abap_true INTO @lv_exists_cs FROM (gc_clfhdrs_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_cm FROM (gc_clfhdrm_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_s FROM (gc_kssks_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_m FROM (gc_ksskm_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_k FROM (gc_ksskk_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED. "#EC CI_CLIENT
        END-TEST-SEAM.
      ELSE.
        TEST-SEAM exists_2_seam.
          SELECT SINGLE @abap_true INTO @lv_exists_cs FROM (gc_clfhdrs_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED WHERE mandt = @iv_client. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_cm FROM (gc_clfhdrm_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED WHERE mandt = @iv_client. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_s FROM (gc_kssks_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED WHERE mandt = @iv_client. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_m FROM (gc_ksskm_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED WHERE mandt = @iv_client. "#EC CI_CLIENT
          SELECT SINGLE @abap_true INTO @lv_exists_k FROM (gc_ksskk_name) "#EC CI_DYNTAB
            CLIENT SPECIFIED WHERE mandt = @iv_client. "#EC CI_CLIENT
        END-TEST-SEAM.
      ENDIF.

      IF lv_exists_cs <> abap_true AND lv_exists_cm <> abap_true
      AND lv_exists_s <> abap_true AND lv_exists_m <> abap_true AND lv_exists_k <> abap_true.
        MESSAGE i033(upgba) WITH 'No data relevant for conversion found' 'in this system.' INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
        cl_upgba_logger=>log->trace_single( ).
        cl_ngc_core_xpra_clf_hdr=>delete_views( ).
        TEST-SEAM log_close_1_seam.
          cl_upgba_logger=>log->close( ).
        END-TEST-SEAM.
        rv_exit = abap_true.
        RETURN.
      ENDIF.
    ELSE.
      TEST-SEAM log_close_2_seam.
        cl_upgba_logger=>log->close( ).
      END-TEST-SEAM.
      rv_exit = abap_true.
      RETURN.
    ENDIF.
  ENDIF.

ENDMETHOD.