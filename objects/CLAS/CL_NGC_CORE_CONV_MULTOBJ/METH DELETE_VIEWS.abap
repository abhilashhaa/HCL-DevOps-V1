METHOD delete_views.

  TRY.
    cl_ngc_core_data_conv=>delete_view( mv_auspu_name ).
    cl_ngc_core_data_conv=>delete_view( mv_kssku_name ).
  CATCH cx_root INTO DATA(lx_root).
    " Error when deleting a view
    IF iv_log_error EQ abap_true.
      cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
    ENDIF.
  ENDTRY.

ENDMETHOD.