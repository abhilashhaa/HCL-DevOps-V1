  METHOD get_all_default_hotkeys.

    IF zcl_abapgit_factory=>get_environment( )->is_merged( ) = abap_true.
      rt_hotkey_actions = get_hotkeys_from_local_intf( ).
    ELSE.
      rt_hotkey_actions = get_hotkeys_from_global_intf( ).
    ENDIF.

  ENDMETHOD.