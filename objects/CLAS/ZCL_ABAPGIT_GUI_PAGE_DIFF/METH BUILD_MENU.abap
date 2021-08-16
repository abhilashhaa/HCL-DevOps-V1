  METHOD build_menu.

    CREATE OBJECT ro_menu.

    add_menu_begin( ro_menu ).
    add_jump_sub_menu( ro_menu ).
    add_filter_sub_menu( ro_menu ).
    add_menu_end( ro_menu ).

  ENDMETHOD.