  METHOD help_submenu.

    CREATE OBJECT ro_menu.

    ro_menu->add(
      iv_txt = 'Tutorial'
      iv_act = zif_abapgit_definitions=>c_action-go_tutorial
    )->add(
      iv_txt = 'Documentation'
      iv_act = zif_abapgit_definitions=>c_action-documentation
    )->add(
      iv_txt = 'Explore'
      iv_act = zif_abapgit_definitions=>c_action-go_explore
    )->add(
      iv_txt = 'Changelog'
      iv_act = zif_abapgit_definitions=>c_action-changelog ).

  ENDMETHOD.