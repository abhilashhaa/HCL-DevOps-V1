  METHOD zif_abapgit_gui_hotkeys~get_hotkey_actions.

    DATA: ls_hotkey_action LIKE LINE OF rt_hotkey_actions.

    ls_hotkey_action-ui_component = 'Patch'.

    ls_hotkey_action-description = |Stage changes|.
    ls_hotkey_action-action      = |stagePatch|.
    ls_hotkey_action-hotkey      = |s|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description = |Refresh local|.
    ls_hotkey_action-action      = |refreshLocal|.
    ls_hotkey_action-hotkey      = |r|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

  ENDMETHOD.