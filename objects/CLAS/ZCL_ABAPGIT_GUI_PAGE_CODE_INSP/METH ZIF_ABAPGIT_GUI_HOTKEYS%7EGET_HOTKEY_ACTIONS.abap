  METHOD zif_abapgit_gui_hotkeys~get_hotkey_actions.

    DATA: ls_hotkey_action LIKE LINE OF rt_hotkey_actions.

    ls_hotkey_action-ui_component = 'Code inspector'.

    ls_hotkey_action-description = |Stage|.
    ls_hotkey_action-action = c_actions-stage.
    ls_hotkey_action-hotkey = |s|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description = |Re-Run|.
    ls_hotkey_action-action = c_actions-rerun.
    ls_hotkey_action-hotkey = |r|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

  ENDMETHOD.