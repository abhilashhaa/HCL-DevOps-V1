  METHOD full_tree.

    DATA: ls_object LIKE LINE OF it_objects,
          ls_commit TYPE zcl_abapgit_git_pack=>ty_commit.


    READ TABLE it_objects INTO ls_object
      WITH KEY type COMPONENTS
        type = zif_abapgit_definitions=>c_type-commit
        sha1 = iv_branch.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'commit not found' ).
    ENDIF.
    ls_commit = zcl_abapgit_git_pack=>decode_commit( ls_object-data ).

    rt_expanded = walk_tree( it_objects = it_objects
                             iv_tree    = ls_commit-tree
                             iv_base    = '/' ).

  ENDMETHOD.