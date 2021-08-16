  METHOD add_menu_end.

    io_menu->add( iv_txt = 'Split/Unified view'
                  iv_act = c_actions-toggle_unified ).

  ENDMETHOD.