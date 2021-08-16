  METHOD fetch_git.

    DATA: lo_branch_list TYPE REF TO zcl_abapgit_git_branch_list,
          lt_upload      TYPE zif_abapgit_definitions=>ty_git_branch_list_tt.

    lo_branch_list = zcl_abapgit_git_transport=>branches( ms_merge-repo->get_url( ) ).

    ms_merge-source = lo_branch_list->find_by_name(
      zcl_abapgit_git_branch_list=>complete_heads_branch_name( mv_source_branch ) ).

    ms_merge-target = lo_branch_list->find_by_name(
      zcl_abapgit_git_branch_list=>complete_heads_branch_name( mo_repo->get_branch_name( ) ) ).

    APPEND ms_merge-source TO lt_upload.
    APPEND ms_merge-target TO lt_upload.

    zcl_abapgit_git_transport=>upload_pack_by_branch(
      EXPORTING
        iv_url          = ms_merge-repo->get_url( )
        iv_branch_name  = ms_merge-repo->get_branch_name( )
        iv_deepen_level = 0
        it_branches     = lt_upload
      IMPORTING
        et_objects      = rt_objects ).

  ENDMETHOD.