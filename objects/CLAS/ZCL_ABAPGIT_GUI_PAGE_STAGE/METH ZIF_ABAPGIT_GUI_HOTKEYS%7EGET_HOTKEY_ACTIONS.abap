  METHOD zif_abapgit_gui_hotkeys~get_hotkey_actions.

    DATA ls_hotkey_action LIKE LINE OF rt_hotkey_actions.

    ls_hotkey_action-ui_component = 'Stage'.
    ls_hotkey_action-description  = |Patch|.
    ls_hotkey_action-action       = 'submitPatch'. " JS function in StageHelper
    ls_hotkey_action-hotkey       = |p|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

    ls_hotkey_action-description  = |Diff|.
    ls_hotkey_action-action       = zif_abapgit_definitions=>c_action-go_diff.
    ls_hotkey_action-hotkey       = |d|.
    INSERT ls_hotkey_action INTO TABLE rt_hotkey_actions.

  ENDMETHOD.