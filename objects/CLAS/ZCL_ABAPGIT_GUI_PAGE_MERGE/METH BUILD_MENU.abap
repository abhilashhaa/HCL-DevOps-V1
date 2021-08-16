  METHOD build_menu.

    CREATE OBJECT ro_menu.

    ro_menu->add( iv_txt = 'Merge'
                  iv_act = c_actions-merge
                  iv_cur = abap_false ).

    IF iv_with_conflict = abap_true.
      ro_menu->add( iv_txt = 'Resolve Conflicts'
                    iv_act = c_actions-res_conflicts ).
    ENDIF.

  ENDMETHOD.