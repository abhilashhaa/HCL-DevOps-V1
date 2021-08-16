  METHOD push_deletions.

    DATA: lo_stage   TYPE REF TO zcl_abapgit_stage,
          ls_comment TYPE zif_abapgit_definitions=>ty_comment.

    FIELD-SYMBOLS: <ls_remote> LIKE LINE OF is_files-remote.

    ASSERT lines( is_files-remote ) > 0.

    CREATE OBJECT lo_stage.

    ls_comment-comment = 'BG: Deletion'.

    LOOP AT is_files-remote ASSIGNING <ls_remote>.

      mi_log->add_info( |removed: { <ls_remote>-path } { <ls_remote>-filename }| ).

      lo_stage->rm( iv_path     = <ls_remote>-path
                    iv_filename = <ls_remote>-filename ).

      CONCATENATE ls_comment-comment zif_abapgit_definitions=>c_newline <ls_remote>-filename
        INTO ls_comment-comment.

    ENDLOOP.

    ls_comment-committer-name  = 'Deletion'.
    ls_comment-committer-email = 'deletion@localhost'.

    io_repo->push( is_comment = ls_comment
                   io_stage   = lo_stage ).

  ENDMETHOD.