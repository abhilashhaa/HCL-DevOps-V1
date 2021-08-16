  METHOD push_auto.

    TYPES: BEGIN OF ty_changed,
             filename   TYPE string,
             path       TYPE string,
             changed_by TYPE xubname,
           END OF ty_changed.

    DATA: ls_comment    TYPE zif_abapgit_definitions=>ty_comment,
          ls_files      TYPE zif_abapgit_definitions=>ty_stage_files,
          lt_changed    TYPE STANDARD TABLE OF ty_changed WITH DEFAULT KEY,
          lt_users      TYPE STANDARD TABLE OF xubname WITH DEFAULT KEY,
          ls_user_files LIKE ls_files,
          lv_changed_by LIKE LINE OF lt_users,
          lo_stage      TYPE REF TO zcl_abapgit_stage.

    FIELD-SYMBOLS: <ls_changed> LIKE LINE OF lt_changed,
                   <ls_remote>  LIKE LINE OF ls_files-remote,
                   <ls_local>   LIKE LINE OF ls_files-local.


    ls_files = zcl_abapgit_factory=>get_stage_logic( )->get( io_repo ).

    LOOP AT ls_files-local ASSIGNING <ls_local>.
      lv_changed_by = zcl_abapgit_objects=>changed_by( <ls_local>-item ).
      APPEND lv_changed_by TO lt_users.
      APPEND INITIAL LINE TO lt_changed ASSIGNING <ls_changed>.
      <ls_changed>-changed_by = lv_changed_by.
      <ls_changed>-filename   = <ls_local>-file-filename.
      <ls_changed>-path       = <ls_local>-file-path.
    ENDLOOP.

    SORT lt_users ASCENDING.
    DELETE ADJACENT DUPLICATES FROM lt_users.

    LOOP AT lt_users INTO lv_changed_by.
      CLEAR: ls_comment.

*     Fill user details
      ls_comment-committer = determine_user_details( lv_changed_by ).

      CREATE OBJECT lo_stage.

      CLEAR ls_user_files.

      LOOP AT ls_files-local ASSIGNING <ls_local>.
        READ TABLE lt_changed WITH KEY
          path = <ls_local>-file-path
          filename = <ls_local>-file-filename
          changed_by = lv_changed_by
          TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          mi_log->add_info( |stage: {
            ls_comment-committer-name } {
            <ls_local>-file-path } {
            <ls_local>-file-filename }| ).

          lo_stage->add( iv_path     = <ls_local>-file-path
                         iv_filename = <ls_local>-file-filename
                         iv_data     = <ls_local>-file-data ).

          APPEND <ls_local> TO ls_user_files-local.

          LOOP AT ls_files-remote ASSIGNING <ls_remote>
              WHERE filename = <ls_local>-file-filename
              AND path <> <ls_local>-file-path
              AND filename <> 'package.devc.xml'.
            mi_log->add_info( |rm: { <ls_remote>-path } { <ls_remote>-filename }| ).

* rm old file when object has moved
            lo_stage->rm(
              iv_path     = <ls_remote>-path
              iv_filename = <ls_remote>-filename ).
            EXIT. " assumption: only one file
          ENDLOOP.
        ENDIF.
      ENDLOOP.

      ls_comment-comment = build_comment( ls_user_files ).

      io_repo->push( is_comment = ls_comment
                     io_stage   = lo_stage ).
    ENDLOOP.

    IF lines( ls_files-remote ) > 0.
      push_deletions( io_repo  = io_repo
                      is_files = ls_files ).
    ENDIF.

  ENDMETHOD.