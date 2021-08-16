  METHOD zif_abapgit_git_operations~push.

* assumption: PUSH is done on top of the currently selected branch

    DATA: ls_push TYPE zcl_abapgit_git_porcelain=>ty_push_result,
          lv_text TYPE string.


    IF ms_data-branch_name CP zif_abapgit_definitions=>c_git_branch-tags.
      lv_text = |You're working on a tag. Currently it's not |
             && |possible to push on tags. Consider creating a branch instead|.
      zcx_abapgit_exception=>raise( lv_text ).
    ENDIF.

    IF ms_data-local_settings-block_commit = abap_true
        AND zcl_abapgit_factory=>get_code_inspector( get_package( )
          )->is_successful( ) = abap_false.
      zcx_abapgit_exception=>raise( |A successful code inspection is required| ).
    ENDIF.

    handle_stage_ignore( io_stage ).

    ls_push = zcl_abapgit_git_porcelain=>push(
      is_comment     = is_comment
      io_stage       = io_stage
      iv_branch_name = get_branch_name( )
      iv_url         = get_url( )
      iv_parent      = get_sha1_remote( )
      it_old_objects = get_objects( ) ).

    set_objects( ls_push-new_objects ).
    set_files_remote( ls_push-new_files ).

    mv_branch = ls_push-branch.

    update_local_checksums( ls_push-updated_files ).

    reset_status( ).

  ENDMETHOD.