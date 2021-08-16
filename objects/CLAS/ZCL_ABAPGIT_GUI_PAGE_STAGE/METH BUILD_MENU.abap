  METHOD build_menu.

    CREATE OBJECT ro_menu.

    IF lines( ms_files-local ) > 0
    OR lines( ms_files-remote ) > 0.
      ro_menu->add( iv_txt = |Diff|
                    iv_act = |{ zif_abapgit_definitions=>c_action-go_diff }?key={ mo_repo->get_key( ) }| ).

      ro_menu->add( iv_txt = |Patch|
                    iv_typ = zif_abapgit_html=>c_action_type-onclick
                    iv_id  = |patchBtn| ).
    ENDIF.

  ENDMETHOD.