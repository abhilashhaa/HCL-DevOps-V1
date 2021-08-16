METHOD create_views.

  "$.Region view: inconinob
  " inconinob: Inconsistent INOB entries (for which there is no KSSK entry).
  DATA(lv_inconinob_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                              `  INOB` && cl_abap_char_utilities=>newline &&
                              `  LEFT OUTER JOIN` && cl_abap_char_utilities=>newline &&
                              `  KSSK ON inob.mandt = kssk.mandt AND inob.cuobj = kssk.objek` && cl_abap_char_utilities=>newline &&
                              `{` && cl_abap_char_utilities=>newline &&
                              `  KEY inob.mandt,` && cl_abap_char_utilities=>newline &&
                              `  KEY inob.cuobj` && cl_abap_char_utilities=>newline &&
                              `} WHERE kssk.clint IS NULL` ##NO_TEXT.
  "$.Endregion view: inconinob

  TRY.
      TEST-SEAM create_view_seam.
        cl_ngc_core_data_conv=>create_view( iv_view_name = mv_inconinob_name iv_view_source = lv_inconinob_source iv_app_name = mv_appl_name iv_client_dependent = abap_false ).
      END-TEST-SEAM.
      rv_success = abap_true.
    CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.
      " Error when creating a view
      rv_success = abap_false.
      me->delete_views( iv_log_error = abap_false ).
      cl_upgba_logger=>log->error( ix_root = lx_root iv_incl_srcpos = abap_true ).
  ENDTRY.

ENDMETHOD.