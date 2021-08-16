  METHOD build_base_menu.

    DATA:
      lo_sort_menu TYPE REF TO zcl_abapgit_html_toolbar.

    CREATE OBJECT lo_sort_menu.

    lo_sort_menu->add(
      iv_txt = 'By Object, Check, Sub-object'
      iv_act = c_actions-sort_1
    )->add(
      iv_txt = 'By Object, Sub-object, Line'
      iv_act = c_actions-sort_2
    )->add(
      iv_txt = 'By Check, Object, Sub-object'
      iv_act = c_actions-sort_3 ).

    CREATE OBJECT ro_menu.

    ro_menu->add( iv_txt = 'Sort'
                  io_sub = lo_sort_menu ).

    ro_menu->add( iv_txt = 'Re-Run'
                  iv_act = c_actions-rerun
                  iv_cur = abap_false ).

  ENDMETHOD.