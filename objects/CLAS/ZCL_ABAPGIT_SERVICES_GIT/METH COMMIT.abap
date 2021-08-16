  METHOD commit.

    DATA: ls_comment TYPE zif_abapgit_definitions=>ty_comment,
          li_user    TYPE REF TO zif_abapgit_persist_user.

    li_user = zcl_abapgit_persistence_user=>get_instance( ).
    li_user->set_repo_git_user_name( iv_url      = io_repo->get_url( )
                                     iv_username = is_commit-committer_name ).
    li_user->set_repo_git_user_email( iv_url     = io_repo->get_url( )
                                      iv_email   = is_commit-committer_email ).

    IF is_commit-committer_name IS INITIAL.
      zcx_abapgit_exception=>raise( 'Commit: Committer name empty' ).
    ELSEIF is_commit-committer_email IS INITIAL.
      zcx_abapgit_exception=>raise( 'Commit: Committer email empty' ).
    ELSEIF is_commit-author_email IS NOT INITIAL AND is_commit-author_name IS INITIAL.
      zcx_abapgit_exception=>raise( 'Commit: Author name empty' ). " Opposite should be OK ?
    ELSEIF is_commit-comment IS INITIAL.
      zcx_abapgit_exception=>raise( 'Commit: empty comment' ).
    ENDIF.

    ls_comment-committer-name  = is_commit-committer_name.
    ls_comment-committer-email = is_commit-committer_email.
    ls_comment-author-name     = is_commit-author_name.
    ls_comment-author-email    = is_commit-author_email.
    ls_comment-comment         = is_commit-comment.

    IF NOT is_commit-body IS INITIAL.
      CONCATENATE ls_comment-comment '' is_commit-body
        INTO ls_comment-comment SEPARATED BY zif_abapgit_definitions=>c_newline.
    ENDIF.

    io_repo->push( is_comment = ls_comment
                   io_stage   = io_stage ).

    COMMIT WORK.

  ENDMETHOD.