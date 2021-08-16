METHOD delete_views.

  TRY.
      TEST-SEAM delete_view_seam.
        cl_ngc_core_data_conv=>delete_view( mv_inconinob_name ).
      END-TEST-SEAM.
    CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.
      " Error when deleting a view.
      IF iv_log_error EQ abap_true.
        cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
      ENDIF.
  ENDTRY.

ENDMETHOD.