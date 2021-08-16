  METHOD zif_abapgit_gui_hotkeys~get_hotkey_actions.

    DATA: ls_hotkey_action LIKE LINE OF rt_hotkey_actions.
    ls_hotkey_action-ui_component = 'Repo'.

    ls_hotkey_action-description   = |Stage changes|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-go_stage.
    ls_hotkey_action-hotkey = |s|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Switch branch|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-git_branch_switch.
    ls_hotkey_action-hotkey = |b|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Installed repo list|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-abapgit_home.
    ls_hotkey_action-hotkey = |o|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Refresh repository|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-repo_refresh.
    ls_hotkey_action-hotkey = |r|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Pull|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-git_pull.
    ls_hotkey_action-hotkey = |p|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Diff|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-go_diff.
    ls_hotkey_action-hotkey = |d|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Uninstall repository|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-repo_purge.
    ls_hotkey_action-hotkey = |u|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Run code inspector|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-repo_code_inspector.
    ls_hotkey_action-hotkey = |i|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Show log|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-repo_log.
    ls_hotkey_action-hotkey = |l|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

  ENDMETHOD.