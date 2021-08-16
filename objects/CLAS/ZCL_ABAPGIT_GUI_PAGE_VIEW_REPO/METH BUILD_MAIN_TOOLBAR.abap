  METHOD build_main_toolbar.

    DATA:
      li_log TYPE REF TO zif_abapgit_log.

    CREATE OBJECT ro_toolbar EXPORTING iv_id = 'toolbar-repo'.

    IF mo_repo->is_offline( ) = abap_false.
      IF iv_rstate IS NOT INITIAL. " Something new at remote
        ro_toolbar->add( iv_txt = 'Pull'
                         iv_act = |{ zif_abapgit_definitions=>c_action-git_pull }?key={ mv_key }|
                         iv_opt = iv_pull_opt ).
      ENDIF.
      IF iv_lstate IS NOT INITIAL. " Something new at local
        ro_toolbar->add( iv_txt = 'Stage'
                         iv_act = |{ zif_abapgit_definitions=>c_action-go_stage }?key={ mv_key }|
                         iv_opt = zif_abapgit_html=>c_html_opt-strong ).
      ENDIF.
      IF iv_rstate IS NOT INITIAL OR iv_lstate IS NOT INITIAL. " Any changes
        ro_toolbar->add( iv_txt = 'Diff'
                         iv_act = |{ zif_abapgit_definitions=>c_action-go_diff }?key={ mv_key }|
                         iv_opt = zif_abapgit_html=>c_html_opt-strong ).
      ENDIF.
      li_log = mo_repo->get_log( ).
      IF li_log IS BOUND AND li_log->count( ) > 0.
        ro_toolbar->add( iv_txt = 'Log'
                         iv_act = |{ zif_abapgit_definitions=>c_action-repo_log }?key={ mv_key }| ).
      ENDIF.
      ro_toolbar->add( iv_txt = 'Branch'
                       io_sub = io_tb_branch ).
      ro_toolbar->add( iv_txt = 'Tag'
                       io_sub = io_tb_tag ).
    ELSE.
      IF mo_repo->has_remote_source( ) = abap_true AND iv_rstate IS NOT INITIAL.
        ro_toolbar->add( iv_txt = 'Pull <sup>zip</sup>'
                         iv_act = |{ zif_abapgit_definitions=>c_action-git_pull }?key={ mv_key }|
                         iv_opt = zif_abapgit_html=>c_html_opt-strong ).
        ro_toolbar->add( iv_txt = 'Diff'
                         iv_act = |{ zif_abapgit_definitions=>c_action-go_diff }?key={ mv_key }|
                         iv_opt = zif_abapgit_html=>c_html_opt-strong ).
      ENDIF.
      ro_toolbar->add( iv_txt = 'Import <sup>zip</sup>'
                       iv_act = |{ zif_abapgit_definitions=>c_action-zip_import }?key={ mv_key }|
                       iv_opt = zif_abapgit_html=>c_html_opt-strong ).
      ro_toolbar->add( iv_txt = 'Export <sup>zip</sup>'
                       iv_act = |{ zif_abapgit_definitions=>c_action-zip_export }?key={ mv_key }|
                       iv_opt = zif_abapgit_html=>c_html_opt-strong ).
      li_log = mo_repo->get_log( ).
      IF li_log IS BOUND AND li_log->count( ) > 0.
        ro_toolbar->add( iv_txt = 'Log'
                         iv_act = |{ zif_abapgit_definitions=>c_action-repo_log }?key={ mv_key }| ).
      ENDIF.
    ENDIF.

    ro_toolbar->add( iv_txt = 'Advanced'
                     io_sub = io_tb_advanced ).

    ro_toolbar->add( iv_txt = 'View'
                     io_sub = build_view_menu( ) ).

    ro_toolbar->add( iv_txt = 'Refresh'
                     iv_act = |{ zif_abapgit_definitions=>c_action-repo_refresh }?key={ mv_key }|
                     iv_opt = zif_abapgit_html=>c_html_opt-strong ).

    ro_toolbar->add( iv_txt = zcl_abapgit_html=>icon( iv_name = 'cog' )
                     iv_act = |{ zif_abapgit_definitions=>c_action-repo_settings }?key={ mv_key }|
                     iv_title = `Repository Settings` ).


  ENDMETHOD.