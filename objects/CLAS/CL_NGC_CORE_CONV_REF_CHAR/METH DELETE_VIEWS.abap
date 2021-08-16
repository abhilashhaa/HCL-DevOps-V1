METHOD delete_views.

  TRY.
    cl_ngc_core_data_conv=>delete_view( gv_siblchrs_name ).

    CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.
      " Error when deleting a view.
      IF iv_log_error EQ abap_true.
        cl_upgba_logger=>log->error(
          ix_root        = lx_root
          iv_incl_srcpos = abap_true
        ).
      ENDIF.
  ENDTRY.

  TRY.
      cl_ngc_core_data_conv=>delete_view( gv_refbou_name ).

  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
        cl_upgba_logger=>log->error(
          ix_root        = lx_root
          iv_incl_srcpos = abap_true
        ).
      ENDIF.
  ENDTRY.

  TRY.
      cl_ngc_core_data_conv=>delete_view( gv_refbo_name ).

  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
        cl_upgba_logger=>log->error(
          ix_root        = lx_root
          iv_incl_srcpos = abap_true
        ).
      ENDIF.
  ENDTRY.

  TRY.
      cl_ngc_core_data_conv=>delete_view( gv_refkssk_name ).

  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
        cl_upgba_logger=>log->error(
          ix_root        = lx_root
          iv_incl_srcpos = abap_true
        ).
      ENDIF.
  ENDTRY.

  TRY.
      cl_ngc_core_data_conv=>delete_view( gv_refchars_name ).

  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
        cl_upgba_logger=>log->error(
          ix_root        = lx_root
          iv_incl_srcpos = abap_true
        ).
      ENDIF.
  ENDTRY.

  TRY.
      cl_ngc_core_data_conv=>delete_view( gv_nodes_name ).

  CATCH cx_root INTO lx_root ##CATCH_ALL.
    " Error when deleting a view.
    IF iv_log_error EQ abap_true.
        cl_upgba_logger=>log->error(
          ix_root        = lx_root
          iv_incl_srcpos = abap_true
        ).
    ENDIF.
  ENDTRY.

ENDMETHOD.