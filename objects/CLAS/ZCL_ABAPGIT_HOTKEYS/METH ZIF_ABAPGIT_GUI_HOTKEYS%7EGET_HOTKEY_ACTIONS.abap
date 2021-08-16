  METHOD zif_abapgit_gui_hotkeys~get_hotkey_actions.

    DATA ls_hotkey LIKE LINE OF rt_hotkey_actions.

    ls_hotkey-ui_component = 'Hotkeys'.
    ls_hotkey-action       = c_showhotkeys_action.
    ls_hotkey-description  = 'Show hotkeys help'.
    ls_hotkey-hotkey       = '?'.
    INSERT ls_hotkey INTO TABLE rt_hotkey_actions.

  ENDMETHOD.