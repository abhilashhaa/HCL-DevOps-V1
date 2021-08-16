  METHOD get_hotkeys_by_class_name.

    CALL METHOD (iv_class_name)=>zif_abapgit_gui_hotkeys~get_hotkey_actions
      RECEIVING
        rt_hotkey_actions = rt_hotkeys.

  ENDMETHOD.