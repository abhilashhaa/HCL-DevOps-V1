  METHOD build_menu.

    CREATE OBJECT ro_menu.

    IF mv_compress = abap_true.
      ro_menu->add(
        iv_txt = 'Uncompress Graph'
        iv_act = c_actions-uncompress ).
    ELSE.
      ro_menu->add(
        iv_txt = 'Compress Graph'
        iv_act = c_actions-compress ).
    ENDIF.

    ro_menu->add( iv_txt = 'Refresh'
                  iv_act = c_actions-refresh ).

  ENDMETHOD.