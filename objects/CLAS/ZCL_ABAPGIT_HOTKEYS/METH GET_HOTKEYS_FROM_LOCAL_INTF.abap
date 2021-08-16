  METHOD get_hotkeys_from_local_intf.

    DATA lt_hotkey_actions            LIKE rt_hotkeys.
    DATA lt_interface_implementations TYPE saboo_iimpt.
    FIELD-SYMBOLS <ls_intf_implementation> LIKE LINE OF lt_interface_implementations.
    DATA lv_hotkeys_class_name        LIKE <ls_intf_implementation>-refclsname.
    DATA li_dummy                     TYPE REF TO zif_abapgit_gui_hotkeys.

    lv_hotkeys_class_name        = get_referred_class_name( li_dummy ).
    lt_interface_implementations = get_local_intf_implementations( ).

    LOOP AT lt_interface_implementations ASSIGNING <ls_intf_implementation> WHERE refclsname = lv_hotkeys_class_name.
      lt_hotkey_actions = get_hotkeys_by_class_name( <ls_intf_implementation>-clsname ).
      INSERT LINES OF lt_hotkey_actions INTO TABLE rt_hotkeys.
    ENDLOOP.

  ENDMETHOD.