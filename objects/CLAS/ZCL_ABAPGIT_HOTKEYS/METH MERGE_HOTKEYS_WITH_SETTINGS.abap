  METHOD merge_hotkeys_with_settings.

    DATA lt_user_defined_hotkeys TYPE zif_abapgit_definitions=>tty_hotkey.
    FIELD-SYMBOLS <ls_hotkey> LIKE LINE OF ct_hotkey_actions.
    FIELD-SYMBOLS <ls_user_defined_hotkey> LIKE LINE OF lt_user_defined_hotkeys.

    lt_user_defined_hotkeys = zcl_abapgit_persist_settings=>get_instance( )->read( )->get_hotkeys( ).

    LOOP AT ct_hotkey_actions ASSIGNING <ls_hotkey>.
      READ TABLE lt_user_defined_hotkeys ASSIGNING <ls_user_defined_hotkey>
        WITH TABLE KEY action COMPONENTS
          ui_component = <ls_hotkey>-ui_component
          action       = <ls_hotkey>-action.
      IF sy-subrc = 0.
        <ls_hotkey>-hotkey = <ls_user_defined_hotkey>-hotkey.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.