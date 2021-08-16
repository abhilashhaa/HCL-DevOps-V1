  METHOD post_hotkeys.

    DATA:
      lt_key_bindings TYPE zif_abapgit_definitions=>tty_hotkey,
      ls_key_binding  LIKE LINE OF lt_key_bindings.

    FIELD-SYMBOLS:
      <ls_default_hotkey> LIKE LINE OF mt_default_hotkeys,
      <ls_post_field>     TYPE ihttpnvp.

    LOOP AT mt_post_fields ASSIGNING <ls_post_field> WHERE name CP 'hk~*'.

      FIND FIRST OCCURRENCE OF REGEX `hk~(.+)~(.+)`
        IN <ls_post_field>-name
        SUBMATCHES ls_key_binding-ui_component ls_key_binding-action.
      CHECK sy-subrc = 0.

      READ TABLE mt_default_hotkeys
        ASSIGNING <ls_default_hotkey>
        WITH TABLE KEY action
        COMPONENTS
          ui_component = ls_key_binding-ui_component
          action       = ls_key_binding-action.
      IF sy-subrc = 0 AND <ls_post_field>-value IS NOT INITIAL AND <ls_post_field>-value <> <ls_default_hotkey>-hotkey.
        ls_key_binding-hotkey = <ls_post_field>-value.
        APPEND ls_key_binding TO lt_key_bindings.
      ENDIF.

    ENDLOOP.

    mo_settings->set_hotkeys( lt_key_bindings ).

  ENDMETHOD.