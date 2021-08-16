  METHOD build_tag_dropdown.

    CREATE OBJECT ro_tag_dropdown.

    IF mo_repo->is_offline( ) = abap_true.
      RETURN.
    ENDIF.

    ro_tag_dropdown->add( iv_txt = 'Overview'
                          iv_act = |{ zif_abapgit_definitions=>c_action-go_tag_overview }?key={ mv_key }| ).
    ro_tag_dropdown->add( iv_txt = 'Switch'
                          iv_act = |{ zif_abapgit_definitions=>c_action-git_tag_switch }?key={ mv_key }|
                          iv_opt = iv_wp_opt ).
    ro_tag_dropdown->add( iv_txt = 'Create'
                          iv_act = |{ zif_abapgit_definitions=>c_action-git_tag_create }?key={ mv_key }| ).
    ro_tag_dropdown->add( iv_txt = 'Delete'
                          iv_act = |{ zif_abapgit_definitions=>c_action-git_tag_delete }?key={ mv_key }| ).


  ENDMETHOD.