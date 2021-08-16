  METHOD build_branch_dropdown.

    DATA lo_repo_online TYPE REF TO zcl_abapgit_repo_online.

    CREATE OBJECT ro_branch_dropdown.

    IF mo_repo->is_offline( ) = abap_true.
      RETURN.
    ENDIF.

    ro_branch_dropdown->add( iv_txt = 'Overview'
                             iv_act = |{ zif_abapgit_definitions=>c_action-go_branch_overview }?key={ mv_key }| ).
    ro_branch_dropdown->add( iv_txt = 'Switch'
                             iv_act = |{ zif_abapgit_definitions=>c_action-git_branch_switch }?key={ mv_key }|
                             iv_opt = iv_wp_opt ).
    ro_branch_dropdown->add( iv_txt = 'Create'
                             iv_act = |{ zif_abapgit_definitions=>c_action-git_branch_create }?key={ mv_key }| ).
    ro_branch_dropdown->add( iv_txt = 'Delete'
                             iv_act = |{ zif_abapgit_definitions=>c_action-git_branch_delete }?key={ mv_key }| ).

    lo_repo_online ?= mo_repo. " TODO refactor this disaster
    IF lo_repo_online->get_switched_origin( ) IS NOT INITIAL.
      ro_branch_dropdown->add(
        iv_txt = 'Switch Origin: Revert <sup>beta<sup>'
        iv_act = |{ c_actions-repo_reset_origin }| ).
    ELSE.
      ro_branch_dropdown->add(
        iv_txt = 'Switch Origin: to PR <sup>beta<sup>'
        iv_act = |{ c_actions-repo_switch_origin_to_pr }| ).
    ENDIF.

  ENDMETHOD.