  METHOD walk_tree.

    DATA: ls_object   LIKE LINE OF it_objects,
          lt_expanded LIKE rt_expanded,
          lt_nodes    TYPE zcl_abapgit_git_pack=>ty_nodes_tt.

    FIELD-SYMBOLS: <ls_exp>  LIKE LINE OF rt_expanded,
                   <ls_node> LIKE LINE OF lt_nodes.


    READ TABLE it_objects INTO ls_object
      WITH KEY type COMPONENTS
        type = zif_abapgit_definitions=>c_type-tree
        sha1 = iv_tree.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'tree not found' ).
    ENDIF.
    lt_nodes = zcl_abapgit_git_pack=>decode_tree( ls_object-data ).

    LOOP AT lt_nodes ASSIGNING <ls_node>.
      CASE <ls_node>-chmod.
        WHEN zif_abapgit_definitions=>c_chmod-file
            OR zif_abapgit_definitions=>c_chmod-executable.
          APPEND INITIAL LINE TO rt_expanded ASSIGNING <ls_exp>.
          <ls_exp>-path  = iv_base.
          <ls_exp>-name  = <ls_node>-name.
          <ls_exp>-sha1  = <ls_node>-sha1.
          <ls_exp>-chmod = <ls_node>-chmod.
        WHEN zif_abapgit_definitions=>c_chmod-dir.
          lt_expanded = walk_tree(
            it_objects = it_objects
            iv_tree    = <ls_node>-sha1
            iv_base    = iv_base && <ls_node>-name && '/' ).
          APPEND LINES OF lt_expanded TO rt_expanded.
        WHEN OTHERS.
          zcx_abapgit_exception=>raise( 'walk_tree: unknown chmod' ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.