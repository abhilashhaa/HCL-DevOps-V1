  METHOD build_view_menu.

    CREATE OBJECT ro_toolbar.

    ro_toolbar->add(
        iv_txt = 'Changes First'
        iv_chk = mv_diff_first
        iv_act = c_actions-toggle_diff_first ).

    IF mo_repo->has_remote_source( ) = abap_true.

      ro_toolbar->add(
        iv_txt = 'Changes Only'
        iv_chk = mv_changes_only
        iv_act = c_actions-toggle_changes ).

      ro_toolbar->add(
        iv_txt = 'File Paths'
        iv_chk = boolc( NOT mv_hide_files = abap_true )
        iv_act = c_actions-toggle_hide_files ).

    ENDIF.

    ro_toolbar->add(
      iv_txt = 'Folders'
      iv_chk = mv_show_folders
      iv_act = c_actions-toggle_folders ).

  ENDMETHOD.