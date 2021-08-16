METHOD DELETE_VIEWS.

  TRY.
    TEST-SEAM delete_view_1_seam.
      cl_ngc_core_data_conv=>delete_view( gc_clfhdrs_name ).
    END-TEST-SEAM.
  CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
      cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
    ENDIF.
  ENDTRY.
  TRY.
    TEST-SEAM delete_view_2_seam.
      cl_ngc_core_data_conv=>delete_view( gc_clfhdrm_name ).
    END-TEST-SEAM.
  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
      cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
    ENDIF.
  ENDTRY.
  TRY.
    TEST-SEAM delete_view_3_seam.
      cl_ngc_core_data_conv=>delete_view( gc_kssks_name ).
    END-TEST-SEAM.
  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
      cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
    ENDIF.
  ENDTRY.
  TRY.
    TEST-SEAM delete_view_4_seam.
      cl_ngc_core_data_conv=>delete_view( gc_ksskm_name ).
    END-TEST-SEAM.
  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
      cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
    ENDIF.
  ENDTRY.
  TRY.
    TEST-SEAM delete_view_5_seam.
      cl_ngc_core_data_conv=>delete_view( gc_ksskk_name ).
    END-TEST-SEAM.
  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
      cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
    ENDIF.
  ENDTRY.

ENDMETHOD.