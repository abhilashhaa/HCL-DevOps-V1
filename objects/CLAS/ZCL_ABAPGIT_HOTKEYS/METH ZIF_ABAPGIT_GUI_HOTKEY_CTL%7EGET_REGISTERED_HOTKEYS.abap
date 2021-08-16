  METHOD zif_abapgit_gui_hotkey_ctl~get_registered_hotkeys.

    DATA li_hotkey_provider LIKE LINE OF mt_hotkey_providers.
    DATA lt_hotkeys         LIKE rt_registered_hotkeys.
    FIELD-SYMBOLS <ls_hotkey> LIKE LINE OF lt_hotkeys.

    LOOP AT mt_hotkey_providers INTO li_hotkey_provider.
      APPEND LINES OF li_hotkey_provider->get_hotkey_actions( ) TO lt_hotkeys.
    ENDLOOP.

    merge_hotkeys_with_settings( CHANGING ct_hotkey_actions = lt_hotkeys ).

    " Compress duplicates
    LOOP AT lt_hotkeys ASSIGNING <ls_hotkey>.
      READ TABLE rt_registered_hotkeys WITH KEY hotkey = <ls_hotkey>-hotkey TRANSPORTING NO FIELDS.
      IF sy-subrc = 0. " If found command with same hotkey
        DELETE rt_registered_hotkeys INDEX sy-tabix. " Later registered commands enjoys the priority
      ENDIF.
      APPEND <ls_hotkey> TO rt_registered_hotkeys.
    ENDLOOP.

  ENDMETHOD.