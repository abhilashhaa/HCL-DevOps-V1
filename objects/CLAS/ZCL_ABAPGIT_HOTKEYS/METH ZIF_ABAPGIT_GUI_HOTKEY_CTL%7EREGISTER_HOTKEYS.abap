  METHOD zif_abapgit_gui_hotkey_ctl~register_hotkeys.
    IF ii_hotkeys IS BOUND.
      APPEND ii_hotkeys TO mt_hotkey_providers.
    ENDIF.
  ENDMETHOD.