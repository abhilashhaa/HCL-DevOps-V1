METHOD CREATE_VIEWS.

  " These views handle the mandt automatically (even in the ON clause of the join conditions).

  "$.Region view: clfhdrs
  " clfhdrs: All entries in clf_hdr where the objekp are empty, single object case.
  DATA(lv_clfhdrs_source) = `SELECT FROM` && cl_abap_char_utilities=>newline &&
                            `  CLF_HDR` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  TCLA ON clf_hdr.mandt = tcla.mandt AND clf_hdr.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
                            `{` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.mandt,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.obtab,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.objek,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.mafid,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.klart,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.objekp,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.cuobj,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.tstmp_i,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.user_i,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.tstmp_c,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.user_c` && cl_abap_char_utilities=>newline &&
                            `} WHERE tcla.multobj = ' ' AND clf_hdr.mafid = 'O'` &&
                            ` AND clf_hdr.objekp = ''` ##NO_TEXT.
  "$.Endregion view: clfhdrs

  "$.Region view: clfhdrm
  " clfhdrm: All entries in clf_hdr where the objekp are empty, multi object case.
  DATA(lv_clfhdrm_source) = `SELECT FROM` && cl_abap_char_utilities=>newline &&
                            `  CLF_HDR` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  TCLA ON clf_hdr.mandt = tcla.mandt AND clf_hdr.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
                            `{` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.mandt,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.obtab,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.objek,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.mafid,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.klart,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.objekp,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.cuobj,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.tstmp_i,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.user_i,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.tstmp_c,` && cl_abap_char_utilities=>newline &&
                            `  clf_hdr.user_c` && cl_abap_char_utilities=>newline &&
                            `} WHERE tcla.multobj = 'X' AND clf_hdr.mafid = 'O'` &&
                            ` AND clf_hdr.objekp = ''` ##NO_TEXT.
  "$.Endregion view: clfhdrm

  "$.Region view: kssks
  " kssks: All entries in kssk where there is no corresponding entry in clf_hdr, single object case.
  DATA(lv_kssks_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                            `  KSSK` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  TCLA ON kssk.mandt = tcla.mandt AND kssk.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
                            `  LEFT OUTER JOIN` && cl_abap_char_utilities=>newline &&
                            `  CLF_HDR ON` && cl_abap_char_utilities=>newline &&
                            `    tcla.mandt = clf_hdr.mandt AND` && cl_abap_char_utilities=>newline &&
                            `    tcla.obtab = clf_hdr.obtab AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.objek = clf_hdr.objek AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.mafid = clf_hdr.mafid AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.klart = clf_hdr.klart` && cl_abap_char_utilities=>newline &&
                            `{` && cl_abap_char_utilities=>newline &&
                            `  kssk.mandt AS mandt,` && cl_abap_char_utilities=>newline &&
                            `  tcla.obtab AS obtab,` && cl_abap_char_utilities=>newline &&
                            `  kssk.objek AS objek,` && cl_abap_char_utilities=>newline &&
                            `  kssk.mafid AS mafid,` && cl_abap_char_utilities=>newline &&
                            `  kssk.klart AS klart` && cl_abap_char_utilities=>newline &&
                            `} WHERE kssk.mafid = 'O' AND tcla.multobj = ' ' AND clf_hdr.objek IS NULL` ##NO_TEXT.
  "$.Endregion view: kssks

  "$.Region view: ksskm
  " ksskm: All entries in kssk where there is no corresponding entry in clf_hdr, multi object case.
  DATA(lv_ksskm_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                            `  KSSK` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  TCLA ON kssk.mandt = tcla.mandt AND kssk.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  INOB ON kssk.mandt = inob.mandt AND kssk.objek = inob.cuobj` && cl_abap_char_utilities=>newline &&
                            `  LEFT OUTER JOIN` && cl_abap_char_utilities=>newline &&
                            `  CLF_HDR ON` && cl_abap_char_utilities=>newline &&
                            `    inob.mandt = clf_hdr.mandt AND` && cl_abap_char_utilities=>newline &&
                            `    inob.obtab = clf_hdr.obtab AND` && cl_abap_char_utilities=>newline &&
                            `    inob.objek = clf_hdr.objek AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.mafid = clf_hdr.mafid AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.klart = clf_hdr.klart` && cl_abap_char_utilities=>newline &&
                            `{` && cl_abap_char_utilities=>newline &&
                            `  inob.mandt AS mandt,` && cl_abap_char_utilities=>newline &&
                            `  inob.obtab AS obtab,` && cl_abap_char_utilities=>newline &&
                            `  inob.objek AS objek,` && cl_abap_char_utilities=>newline &&
                            `  kssk.mafid AS mafid,` && cl_abap_char_utilities=>newline &&
                            `  kssk.klart AS klart,` && cl_abap_char_utilities=>newline &&
                            `  inob.cuobj AS cuobj` && cl_abap_char_utilities=>newline &&
                            `} WHERE kssk.mafid = 'O' AND tcla.multobj = 'X' AND clf_hdr.objek IS NULL` ##NO_TEXT.
  "$.Endregion view: ksskm

  "$.Region view: ksskk
  " ksskk: All entries in kssk where there is no corresponding entry in clf_hdr, mafid='K' (class-class assignments) case.
  DATA(lv_ksskk_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                            `  KSSK` && cl_abap_char_utilities=>newline &&
                            `  LEFT OUTER JOIN` && cl_abap_char_utilities=>newline &&
                            `  CLF_HDR ON` && cl_abap_char_utilities=>newline &&
                            `    kssk.mandt = clf_hdr.mandt AND` && cl_abap_char_utilities=>newline &&
                            `    clf_hdr.obtab = 'KLAH' AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.objek = clf_hdr.objek AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.mafid = clf_hdr.mafid AND` && cl_abap_char_utilities=>newline &&
                            `    kssk.klart = clf_hdr.klart` && cl_abap_char_utilities=>newline &&
                            `{` && cl_abap_char_utilities=>newline &&
                            `  kssk.mandt AS mandt,` && cl_abap_char_utilities=>newline &&
                            `  'KLAH' AS obtab,` && cl_abap_char_utilities=>newline &&
                            `  kssk.objek AS objek,` && cl_abap_char_utilities=>newline &&
                            `  kssk.mafid AS mafid,` && cl_abap_char_utilities=>newline &&
                            `  kssk.klart AS klart` && cl_abap_char_utilities=>newline &&
                            `} WHERE kssk.mafid = 'K' AND clf_hdr.objek IS NULL` ##NO_TEXT.
  "$.Endregion view: ksskk

  TRY.
    TEST-SEAM create_view_seam.
      cl_ngc_core_data_conv=>create_view( iv_view_name = gc_clfhdrs_name  iv_view_source = lv_clfhdrs_source  iv_app_name = sy-repid  iv_client_dependent = abap_false ).
      cl_ngc_core_data_conv=>create_view( iv_view_name = gc_clfhdrm_name  iv_view_source = lv_clfhdrm_source  iv_app_name = sy-repid  iv_client_dependent = abap_false ).
      cl_ngc_core_data_conv=>create_view( iv_view_name = gc_kssks_name  iv_view_source = lv_kssks_source  iv_app_name = sy-repid  iv_client_dependent = abap_false ).
      cl_ngc_core_data_conv=>create_view( iv_view_name = gc_ksskm_name  iv_view_source = lv_ksskm_source  iv_app_name = sy-repid  iv_client_dependent = abap_false ).
      cl_ngc_core_data_conv=>create_view( iv_view_name = gc_ksskk_name  iv_view_source = lv_ksskk_source  iv_app_name = sy-repid  iv_client_dependent = abap_false ).
    END-TEST-SEAM.
    rv_success = abap_true.
  CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.
    " Error when creating a view
    rv_success = abap_false.
    cl_ngc_core_xpra_clf_hdr=>delete_views( iv_log_error = abap_false ).
    cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
  ENDTRY.

ENDMETHOD.