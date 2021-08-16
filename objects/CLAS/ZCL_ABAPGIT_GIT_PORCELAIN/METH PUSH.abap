  METHOD push.

    DATA: lt_expanded TYPE zif_abapgit_definitions=>ty_expanded_tt,
          lt_blobs    TYPE zif_abapgit_definitions=>ty_files_tt,
          lv_sha1     TYPE zif_abapgit_definitions=>ty_sha1,
          lv_new_tree TYPE zif_abapgit_definitions=>ty_sha1,
          lt_trees    TYPE ty_trees_tt,
          lt_stage    TYPE zif_abapgit_definitions=>ty_stage_tt.

    FIELD-SYMBOLS: <ls_stage>   LIKE LINE OF lt_stage,
                   <ls_updated> LIKE LINE OF rs_result-updated_files,
                   <ls_exp>     LIKE LINE OF lt_expanded.


    lt_expanded = full_tree( it_objects = it_old_objects
                             iv_branch  = iv_parent ).

    lt_stage = io_stage->get_all( ).
    LOOP AT lt_stage ASSIGNING <ls_stage>.

      " Save file ref to updated files table
      APPEND INITIAL LINE TO rs_result-updated_files ASSIGNING <ls_updated>.
      MOVE-CORRESPONDING <ls_stage>-file TO <ls_updated>.

      CASE <ls_stage>-method.
        WHEN zif_abapgit_definitions=>c_method-add.

          APPEND <ls_stage>-file TO lt_blobs.

          READ TABLE lt_expanded ASSIGNING <ls_exp> WITH KEY
            name = <ls_stage>-file-filename
            path = <ls_stage>-file-path.
          IF sy-subrc <> 0. " new files
            APPEND INITIAL LINE TO lt_expanded ASSIGNING <ls_exp>.
            <ls_exp>-name  = <ls_stage>-file-filename.
            <ls_exp>-path  = <ls_stage>-file-path.
            <ls_exp>-chmod = zif_abapgit_definitions=>c_chmod-file.
          ENDIF.

          lv_sha1 = zcl_abapgit_hash=>sha1( iv_type = zif_abapgit_definitions=>c_type-blob
                                            iv_data = <ls_stage>-file-data ).
          IF <ls_exp>-sha1 <> lv_sha1.
            <ls_exp>-sha1 = lv_sha1.
          ENDIF.

          <ls_updated>-sha1 = lv_sha1.   "New sha1

        WHEN zif_abapgit_definitions=>c_method-rm.
          DELETE lt_expanded
            WHERE name = <ls_stage>-file-filename
            AND path = <ls_stage>-file-path.
          ASSERT sy-subrc = 0.

          CLEAR <ls_updated>-sha1.       " Mark as deleted

        WHEN OTHERS.
          zcx_abapgit_exception=>raise( 'stage method not supported, todo' ).
      ENDCASE.
    ENDLOOP.

    lt_trees = build_trees( lt_expanded ).

    receive_pack_push(
      EXPORTING
        is_comment     = is_comment
        it_trees       = lt_trees
        iv_branch_name = iv_branch_name
        iv_url         = iv_url
        iv_parent      = iv_parent
        iv_parent2     = io_stage->get_merge_source( )
        it_blobs       = lt_blobs
      IMPORTING
        ev_new_commit  = rs_result-branch
        et_new_objects = rs_result-new_objects
        ev_new_tree    = lv_new_tree ).

    APPEND LINES OF it_old_objects TO rs_result-new_objects.
    walk( EXPORTING it_objects = rs_result-new_objects
                    iv_sha1 = lv_new_tree
                    iv_path = '/'
          CHANGING ct_files = rs_result-new_files ).

  ENDMETHOD.