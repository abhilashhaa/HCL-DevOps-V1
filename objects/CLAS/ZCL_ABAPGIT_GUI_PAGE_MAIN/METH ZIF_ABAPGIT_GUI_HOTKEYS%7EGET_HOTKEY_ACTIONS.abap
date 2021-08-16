  METHOD zif_abapgit_gui_hotkeys~get_hotkey_actions.

    DATA: ls_hotkey_action LIKE LINE OF rt_hotkey_actions.

    ls_hotkey_action-ui_component = 'Main'.

    ls_hotkey_action-description   = |abapGit settings|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-go_settings.
    ls_hotkey_action-hotkey = |x|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description   = |Add online repository|.
    ls_hotkey_action-action = zif_abapgit_definitions=>c_action-repo_newonline.
    ls_hotkey_action-hotkey = |n|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

  ENDMETHOD.