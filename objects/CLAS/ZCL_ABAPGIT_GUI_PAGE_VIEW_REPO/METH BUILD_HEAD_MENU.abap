  METHOD build_head_menu.

    DATA: lo_tb_advanced TYPE REF TO zcl_abapgit_html_toolbar,
          lo_tb_branch   TYPE REF TO zcl_abapgit_html_toolbar,
          lo_tb_tag      TYPE REF TO zcl_abapgit_html_toolbar,
          lv_wp_opt      LIKE zif_abapgit_html=>c_html_opt-crossout,
          lv_pull_opt    LIKE zif_abapgit_html=>c_html_opt-crossout.

    IF mo_repo->get_local_settings( )-write_protected = abap_true.
      lv_wp_opt   = zif_abapgit_html=>c_html_opt-crossout.
      lv_pull_opt = zif_abapgit_html=>c_html_opt-crossout.
    ELSE.
      lv_pull_opt = zif_abapgit_html=>c_html_opt-strong.
    ENDIF.

    lo_tb_branch = build_branch_dropdown( lv_wp_opt ).

    lo_tb_tag = build_tag_dropdown( lv_wp_opt ).

    lo_tb_advanced = build_advanced_dropdown(
                         iv_wp_opt = lv_wp_opt
                         iv_rstate = iv_rstate
                         iv_lstate = iv_lstate ).

    ro_toolbar = build_main_toolbar(
                     iv_pull_opt    = lv_pull_opt
                     iv_rstate      = iv_rstate
                     iv_lstate      = iv_lstate
                     io_tb_branch   = lo_tb_branch
                     io_tb_tag      = lo_tb_tag
                     io_tb_advanced = lo_tb_advanced ).

  ENDMETHOD.