  METHOD get_hotkeys_from_global_intf.

    DATA: lt_hotkey_actions LIKE rt_hotkeys,
          lo_interface      TYPE REF TO cl_oo_interface,
          li_dummy          TYPE REF TO zif_abapgit_gui_hotkeys,
          lt_classes        TYPE seo_relkeys.

    FIELD-SYMBOLS: <ls_class> LIKE LINE OF lt_classes.

    TRY.
        lo_interface ?= cl_oo_class=>get_instance( get_referred_class_name( li_dummy ) ).
      CATCH cx_class_not_existent.
        RETURN.
    ENDTRY.

    lt_classes = lo_interface->get_implementing_classes( ).
    lt_classes = filter_relevant_classes( lt_classes ). " For security reasons

    LOOP AT lt_classes ASSIGNING <ls_class>.
      lt_hotkey_actions = get_hotkeys_by_class_name( <ls_class>-clsname ).
      INSERT LINES OF lt_hotkey_actions INTO TABLE rt_hotkeys.
    ENDLOOP.

  ENDMETHOD.