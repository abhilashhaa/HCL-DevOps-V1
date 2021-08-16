  METHOD create_views.

    " These views handle the mandt automatically (even in the ON clause of the join conditions).

    "$.Region view: refchars

    DATA(lv_refchars_source) =
      `select distinct from cabn` && cl_abap_char_utilities=>newline &&
      `  inner join ausp on cabn.atinn = ausp.atinn` && cl_abap_char_utilities=>newline &&
      `  inner join ` && gv_nodes_name && ` on ausp.klart = ` && gv_nodes_name && `.klart and `
                                          && ` ausp.objek = ` && gv_nodes_name && `.cuobj` && cl_abap_char_utilities=>newline &&
      `{` && cl_abap_char_utilities=>newline &&
      `  ` && gv_nodes_name && `.obtab,` && cl_abap_char_utilities=>newline &&
      `  ` && gv_nodes_name && `.objek,` && cl_abap_char_utilities=>newline &&
      `  ausp.objek as auspobjek,` && cl_abap_char_utilities=>newline &&
      `  ausp.atinn,` && cl_abap_char_utilities=>newline &&
      `  ausp.klart,` && cl_abap_char_utilities=>newline &&
      `  cabn.attab,` && cl_abap_char_utilities=>newline &&
      `  cabn.atfel,` && cl_abap_char_utilities=>newline &&
      `  ausp.datuv,` && cl_abap_char_utilities=>newline &&
      `  cabn.atnam` && cl_abap_char_utilities=>newline ##NO_TEXT.
    lv_refchars_source = lv_refchars_source &&
      `} where cabn.lkenz = ' ' and cabn.atxac = ' ' and cabn.attab <> '' and ` && gv_nodes_name && `.redun = ' '` && cl_abap_char_utilities=>newline &&
      `union all` && cl_abap_char_utilities=>newline &&
      `  select distinct from cabn` && cl_abap_char_utilities=>newline &&
      `  inner join cabnz on cabn.atinn = cabnz.atinn` && cl_abap_char_utilities=>newline &&
      `  inner join ausp on cabn.atinn = ausp.atinn` && cl_abap_char_utilities=>newline &&
      `  inner join ` && gv_nodes_name && ` on ausp.klart = ` && gv_nodes_name && `.klart and `
                                          && ` ausp.objek = ` && gv_nodes_name && `.cuobj` && cl_abap_char_utilities=>newline &&
      `{` && cl_abap_char_utilities=>newline &&
      `  ` && gv_nodes_name && `.obtab,` && cl_abap_char_utilities=>newline &&
      `  ` && gv_nodes_name && `.objek,` && cl_abap_char_utilities=>newline &&
      `  ausp.objek as auspobjek,` && cl_abap_char_utilities=>newline &&
      `  ausp.atinn,` && cl_abap_char_utilities=>newline &&
      `  ausp.klart,` && cl_abap_char_utilities=>newline &&
      `  cabnz.attab,` && cl_abap_char_utilities=>newline &&
      `  cabnz.atfel,` && cl_abap_char_utilities=>newline &&
      `  ausp.datuv,` && cl_abap_char_utilities=>newline &&
      `  cabn.atnam` && cl_abap_char_utilities=>newline ##NO_TEXT.
    lv_refchars_source = lv_refchars_source &&
      `} where cabn.lkenz = ' ' and cabn.atxac = 'X' and ` && gv_nodes_name && `.redun = ' '` ##NO_TEXT.

    "$.Endregion view: refchars

    TRY.
        mo_conv_util->create_view(
          iv_view_name        = gv_nodes_name
          iv_view_source      = cl_ngc_core_conv_util=>gv_nodeleaf_view_source
          iv_app_name         = mv_appl_name
        ).
        mo_conv_util->create_view(
          iv_view_name        = gv_refchars_name
          iv_view_source      = lv_refchars_source
          iv_app_name         = mv_appl_name
        ).

        rv_success = abap_true.

      CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.

        " Error when creating a view
        rv_success = abap_false.
        me->delete_views( iv_log_error = abap_false ).
        mo_conv_logger->log_error( lx_root ).
    ENDTRY.

  ENDMETHOD.