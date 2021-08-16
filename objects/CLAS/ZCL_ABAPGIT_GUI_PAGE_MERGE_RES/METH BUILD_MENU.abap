  METHOD build_menu.

    CREATE OBJECT ro_menu.
    ro_menu->add( iv_txt = 'Toggle merge mode'
                  iv_act = c_actions-toggle_mode ).
    ro_menu->add( iv_txt = 'Cancel'
                  iv_act = c_actions-cancel ).

  ENDMETHOD.