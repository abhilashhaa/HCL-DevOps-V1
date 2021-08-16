  METHOD push_fixed.

    DATA: ls_comment TYPE zif_abapgit_definitions=>ty_comment,
          ls_files   TYPE zif_abapgit_definitions=>ty_stage_files,
          lo_stage   TYPE REF TO zcl_abapgit_stage.

    FIELD-SYMBOLS: <ls_local>  LIKE LINE OF ls_files-local,
                   <ls_remote> LIKE LINE OF ls_files-remote.


    ls_files = zcl_abapgit_factory=>get_stage_logic( )->get( io_repo ).
    ASSERT lines( ls_files-local ) > 0
        OR lines( ls_files-remote ) > 0.

    CREATE OBJECT lo_stage.

    LOOP AT ls_files-local ASSIGNING <ls_local>.
      mi_log->add_info( |stage: { <ls_local>-file-path } { <ls_local>-file-filename }| ).
      lo_stage->add( iv_path     = <ls_local>-file-path
                     iv_filename = <ls_local>-file-filename
                     iv_data     = <ls_local>-file-data ).
    ENDLOOP.

    LOOP AT ls_files-remote ASSIGNING <ls_remote>.

      mi_log->add_info( |removed: { <ls_remote>-path } { <ls_remote>-filename }| ).

      lo_stage->rm( iv_path     = <ls_remote>-path
                    iv_filename = <ls_remote>-filename ).

    ENDLOOP.

    ls_comment-committer-name  = iv_name.
    ls_comment-committer-email = iv_email.
    ls_comment-comment         = build_comment( ls_files ).

    io_repo->push( is_comment = ls_comment
                   io_stage   = lo_stage ).

  ENDMETHOD.