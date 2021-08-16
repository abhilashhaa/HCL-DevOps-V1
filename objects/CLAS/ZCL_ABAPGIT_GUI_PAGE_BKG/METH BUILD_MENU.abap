  METHOD build_menu.

    CREATE OBJECT ro_menu.

    ro_menu->add( iv_txt = 'Run background logic'
                  iv_act = zif_abapgit_definitions=>c_action-go_background_run ).

  ENDMETHOD.