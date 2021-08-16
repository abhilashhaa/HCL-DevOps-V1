  METHOD fetch_remote.

    DATA: li_progress TYPE REF TO zif_abapgit_progress,
          ls_pull     TYPE zcl_abapgit_git_porcelain=>ty_pull_result.

    IF mv_request_remote_refresh = abap_false.
      RETURN.
    ENDIF.

    li_progress = zcl_abapgit_progress=>get_instance( 1 ).

    li_progress->show( iv_current = 1
                       iv_text    = 'Fetch remote files' ).

    ls_pull = zcl_abapgit_git_porcelain=>pull(
      iv_url         = get_url( )
      iv_branch_name = get_branch_name( ) ).

    set_files_remote( ls_pull-files ).
    set_objects( ls_pull-objects ).
    mv_branch = ls_pull-branch.

  ENDMETHOD.