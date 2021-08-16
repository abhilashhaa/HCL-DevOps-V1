  METHOD receive_pack_push.

    DATA: lv_time   TYPE zcl_abapgit_time=>ty_unixtime,
          lv_commit TYPE xstring,
          lv_pack   TYPE xstring,
          ls_object LIKE LINE OF et_new_objects,
          ls_commit TYPE zcl_abapgit_git_pack=>ty_commit,
          lv_uindex TYPE sy-index.

    FIELD-SYMBOLS: <ls_tree> LIKE LINE OF it_trees,
                   <ls_blob> LIKE LINE OF it_blobs.


    lv_time = zcl_abapgit_time=>get_unix( ).

    READ TABLE it_trees ASSIGNING <ls_tree> WITH KEY path = '/'.
    ASSERT sy-subrc = 0.

* new commit
    ls_commit-committer = |{ is_comment-committer-name
      } <{ is_comment-committer-email }> { lv_time }|.
    IF is_comment-author-name IS NOT INITIAL.
      ls_commit-author = |{ is_comment-author-name
        } <{ is_comment-author-email }> { lv_time }|.
    ELSE.
      ls_commit-author = ls_commit-committer.
    ENDIF.

    ls_commit-tree      = <ls_tree>-sha1.
    ls_commit-parent    = iv_parent.
    ls_commit-parent2   = iv_parent2.
    ls_commit-body      = is_comment-comment.
    lv_commit = zcl_abapgit_git_pack=>encode_commit( ls_commit ).

    ls_object-sha1 = zcl_abapgit_hash=>sha1( iv_type = zif_abapgit_definitions=>c_type-commit
                                             iv_data = lv_commit ).
    ls_object-type = zif_abapgit_definitions=>c_type-commit.
    ls_object-data = lv_commit.
    APPEND ls_object TO et_new_objects.

    LOOP AT it_trees ASSIGNING <ls_tree>.
      CLEAR ls_object.
      ls_object-sha1 = <ls_tree>-sha1.

      READ TABLE et_new_objects
        WITH KEY type COMPONENTS
          type = zif_abapgit_definitions=>c_type-tree
          sha1 = ls_object-sha1
        TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
* two identical trees added at the same time, only add one to the pack
        CONTINUE.
      ENDIF.

      ls_object-type = zif_abapgit_definitions=>c_type-tree.
      ls_object-data = <ls_tree>-data.
      lv_uindex = lv_uindex + 1.
      ls_object-index = lv_uindex.
      APPEND ls_object TO et_new_objects.
    ENDLOOP.

    LOOP AT it_blobs ASSIGNING <ls_blob>.
      CLEAR ls_object.
      ls_object-sha1 = zcl_abapgit_hash=>sha1(
        iv_type = zif_abapgit_definitions=>c_type-blob
        iv_data = <ls_blob>-data ).

      READ TABLE et_new_objects
        WITH KEY type COMPONENTS
          type = zif_abapgit_definitions=>c_type-blob
          sha1 = ls_object-sha1
        TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
* two identical files added at the same time, only add one blob to the pack
        CONTINUE.
      ENDIF.

      ls_object-type = zif_abapgit_definitions=>c_type-blob.
* note <ls_blob>-data can be empty, #1857 allow empty files - some more checks needed?
      ls_object-data = <ls_blob>-data.
      lv_uindex = lv_uindex + 1.
      ls_object-index = lv_uindex.
      APPEND ls_object TO et_new_objects.
    ENDLOOP.

    lv_pack = zcl_abapgit_git_pack=>encode( et_new_objects ).

    ev_new_commit = zcl_abapgit_hash=>sha1(
      iv_type = zif_abapgit_definitions=>c_type-commit
      iv_data = lv_commit ).

    zcl_abapgit_git_transport=>receive_pack(
      iv_url         = iv_url
      iv_old         = iv_parent
      iv_new         = ev_new_commit
      iv_branch_name = iv_branch_name
      iv_pack        = lv_pack ).

    ev_new_tree = ls_commit-tree.

  ENDMETHOD.