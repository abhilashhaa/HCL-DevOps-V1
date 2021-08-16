  METHOD build_menu.

    DATA: lv_opt TYPE c LENGTH 1.

    ro_menu = build_base_menu( ).

    IF is_stage_allowed( ) = abap_false.
      lv_opt = zif_abapgit_html=>c_html_opt-crossout.
    ENDIF.

    IF mo_repo->is_offline( ) = abap_true.
      RETURN.
    ENDIF.

    IF mo_stage IS BOUND.

      " Staging info already available, we can directly
      " offer to commit

      ro_menu->add( iv_txt = 'Commit'
                    iv_act = c_actions-commit
                    iv_cur = abap_false
                    iv_opt = lv_opt ).

    ELSE.

      ro_menu->add( iv_txt = 'Stage'
                    iv_act = c_actions-stage
                    iv_cur = abap_false
                    iv_opt = lv_opt ).

    ENDIF.

  ENDMETHOD.