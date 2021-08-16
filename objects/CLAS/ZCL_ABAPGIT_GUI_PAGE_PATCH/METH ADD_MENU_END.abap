  METHOD add_menu_end.

    io_menu->add( iv_txt = 'Stage'
                  iv_act = c_actions-stage
                  iv_id  = 'stage'
                  iv_typ = zif_abapgit_html=>c_action_type-dummy ).

  ENDMETHOD.