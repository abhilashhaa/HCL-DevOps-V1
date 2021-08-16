  METHOD build_advanced_dropdown.

    DATA:
      lv_crossout LIKE zif_abapgit_html=>c_html_opt-crossout.

    CREATE OBJECT ro_advanced_dropdown.

    IF iv_rstate IS NOT INITIAL OR iv_lstate IS NOT INITIAL. " In case of asyncronicities
      ro_advanced_dropdown->add( iv_txt = 'Reset Local (Force Pull)'
                                 iv_act = |{ zif_abapgit_definitions=>c_action-git_reset }?key={ mv_key }|
                                 iv_opt = iv_wp_opt ).
    ENDIF.

    IF mo_repo->is_offline( ) = abap_false. " Online ?
      ro_advanced_dropdown->add( iv_txt = 'Background Mode'
                                 iv_act = |{ zif_abapgit_definitions=>c_action-go_background }?key={ mv_key }| ).
      ro_advanced_dropdown->add( iv_txt = 'Change Remote'
                                 iv_act = |{ zif_abapgit_definitions=>c_action-repo_remote_change }?key={ mv_key }| ).
      ro_advanced_dropdown->add( iv_txt = 'Make Off-line'
                                 iv_act = |{ zif_abapgit_definitions=>c_action-repo_remote_detach }?key={ mv_key }| ).
      ro_advanced_dropdown->add( iv_txt = 'Force Stage'
                                 iv_act = |{ zif_abapgit_definitions=>c_action-go_stage }?key={ mv_key }| ).

      CLEAR lv_crossout.
      IF zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-transport_to_branch ) = abap_false.
        lv_crossout = zif_abapgit_html=>c_html_opt-crossout.
      ENDIF.
      ro_advanced_dropdown->add(
        iv_txt = 'Transport to Branch'
        iv_act = |{ zif_abapgit_definitions=>c_action-repo_transport_to_branch }?key={ mv_key }|
        iv_opt = lv_crossout ).

    ELSE.
      ro_advanced_dropdown->add( iv_txt = 'Make On-line'
                                 iv_act = |{ zif_abapgit_definitions=>c_action-repo_remote_attach }?key={ mv_key }| ).
    ENDIF.

    IF mv_are_changes_recorded_in_tr = abap_true.
      ro_advanced_dropdown->add(
          iv_txt  = 'Add all objects to transport request'
          iv_act = |{ zif_abapgit_definitions=>c_action-repo_add_all_obj_to_trans_req }?key={ mv_key }| ).
    ENDIF.

    ro_advanced_dropdown->add( iv_txt = 'Syntax Check'
                               iv_act = |{ zif_abapgit_definitions=>c_action-repo_syntax_check }?key={ mv_key }| ).
    ro_advanced_dropdown->add( iv_txt = 'Run Code Inspector'
                               iv_act = |{ zif_abapgit_definitions=>c_action-repo_code_inspector }?key={ mv_key }| ).

    CLEAR lv_crossout.
    IF zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-update_local_checksum ) = abap_false.
      lv_crossout = zif_abapgit_html=>c_html_opt-crossout.
    ENDIF.
    ro_advanced_dropdown->add( iv_txt = 'Update Local Checksums'
                               iv_act = |{ zif_abapgit_definitions=>c_action-repo_refresh_checksums }?key={ mv_key }|
                               iv_opt = lv_crossout ).

    IF mo_repo->get_dot_abapgit( )->get_master_language( ) <> sy-langu.
      ro_advanced_dropdown->add(
        iv_txt = 'Open in Master Language'
        iv_act = |{ zif_abapgit_definitions=>c_action-repo_open_in_master_lang }?key={ mv_key }| ).
    ENDIF.

    ro_advanced_dropdown->add( iv_txt = 'Remove'
                               iv_act = |{ zif_abapgit_definitions=>c_action-repo_remove }?key={ mv_key }| ).

    CLEAR lv_crossout.
    IF mo_repo->get_local_settings( )-write_protected = abap_true
        OR zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-uninstall ) = abap_false.
      lv_crossout = zif_abapgit_html=>c_html_opt-crossout.
    ENDIF.
    ro_advanced_dropdown->add( iv_txt = 'Uninstall'
                               iv_act = |{ zif_abapgit_definitions=>c_action-repo_purge }?key={ mv_key }|
                               iv_opt = lv_crossout ).

  ENDMETHOD.