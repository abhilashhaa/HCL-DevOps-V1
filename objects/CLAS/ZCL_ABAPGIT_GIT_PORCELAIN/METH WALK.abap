  METHOD walk.

    DATA: lv_path  TYPE string,
          ls_file  LIKE LINE OF ct_files,
          lt_nodes TYPE zcl_abapgit_git_pack=>ty_nodes_tt.

    FIELD-SYMBOLS: <ls_tree> LIKE LINE OF it_objects,
                   <ls_blob> LIKE LINE OF it_objects,
                   <ls_node> LIKE LINE OF lt_nodes.


    READ TABLE it_objects ASSIGNING <ls_tree>
      WITH KEY type COMPONENTS
        type = zif_abapgit_definitions=>c_type-tree
        sha1 = iv_sha1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Walk, tree not found' ).
    ENDIF.

    lt_nodes = zcl_abapgit_git_pack=>decode_tree( <ls_tree>-data ).

    LOOP AT lt_nodes ASSIGNING <ls_node>.
      IF <ls_node>-chmod = zif_abapgit_definitions=>c_chmod-file.
        READ TABLE it_objects ASSIGNING <ls_blob>
          WITH KEY type COMPONENTS
            type = zif_abapgit_definitions=>c_type-blob
            sha1 = <ls_node>-sha1.
        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise( 'Walk, blob not found' ).
        ENDIF.

        CLEAR ls_file.
        ls_file-path     = iv_path.
        ls_file-filename = <ls_node>-name.
        ls_file-data     = <ls_blob>-data.
        ls_file-sha1     = <ls_blob>-sha1.
        APPEND ls_file TO ct_files.
      ENDIF.
    ENDLOOP.

    LOOP AT lt_nodes ASSIGNING <ls_node> WHERE chmod = zif_abapgit_definitions=>c_chmod-dir.
      CONCATENATE iv_path <ls_node>-name '/' INTO lv_path.
      walk( EXPORTING it_objects = it_objects
                      iv_sha1 = <ls_node>-sha1
                      iv_path = lv_path
            CHANGING ct_files = ct_files ).
    ENDLOOP.

  ENDMETHOD.