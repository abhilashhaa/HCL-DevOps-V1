  METHOD zif_abapgit_repo_srv~new_online.

    DATA: ls_repo        TYPE zif_abapgit_persistence=>ty_repo,
          lv_branch_name LIKE iv_branch_name,
          lv_key         TYPE zif_abapgit_persistence=>ty_repo-key,
          ls_dot_abapgit TYPE zif_abapgit_dot_abapgit=>ty_dot_abapgit.


    ASSERT NOT iv_url IS INITIAL
      AND NOT iv_package IS INITIAL.

    lv_branch_name = iv_branch_name.
    IF lv_branch_name IS INITIAL.
      lv_branch_name = zif_abapgit_definitions=>c_git_branch-master.
    ENDIF.
    IF -1 = find(
        val = lv_branch_name
        sub = zif_abapgit_definitions=>c_git_branch-heads_prefix ).
      " Assume short branch name was received
      lv_branch_name = zif_abapgit_definitions=>c_git_branch-heads_prefix && lv_branch_name.
    ENDIF.

    IF zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-create_repo ) = abap_false.
      zcx_abapgit_exception=>raise( 'Not authorized' ).
    ENDIF.

    validate_package( iv_package = iv_package
                      iv_ign_subpkg = iv_ign_subpkg ).

    zcl_abapgit_url=>validate( |{ iv_url }| ).

    ls_dot_abapgit = zcl_abapgit_dot_abapgit=>build_default( )->get_data( ).
    ls_dot_abapgit-folder_logic = iv_folder_logic.

    lv_key = zcl_abapgit_persist_factory=>get_repo( )->add(
      iv_url          = iv_url
      iv_branch_name  = lv_branch_name " local !
      iv_display_name = iv_display_name
      iv_package      = iv_package
      iv_offline      = abap_false
      is_dot_abapgit  = ls_dot_abapgit ).
    TRY.
        ls_repo = zcl_abapgit_persist_factory=>get_repo( )->read( lv_key ).
      CATCH zcx_abapgit_not_found.
        zcx_abapgit_exception=>raise( 'new_online not found' ).
    ENDTRY.

    ro_repo ?= instantiate_and_add( ls_repo ).

    IF ls_repo-local_settings-ignore_subpackages <> iv_ign_subpkg.
      ls_repo-local_settings-ignore_subpackages = iv_ign_subpkg.
    ENDIF.
    ls_repo-local_settings-serialize_master_lang_only = iv_master_lang_only.
    ro_repo->set_local_settings( ls_repo-local_settings ).

    ro_repo->refresh( ).
    ro_repo->find_remote_dot_abapgit( ).

  ENDMETHOD.