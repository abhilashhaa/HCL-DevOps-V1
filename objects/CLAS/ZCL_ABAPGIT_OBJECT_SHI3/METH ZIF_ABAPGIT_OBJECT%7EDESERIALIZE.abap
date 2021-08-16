  METHOD zif_abapgit_object~deserialize.

    DATA: ls_msg    TYPE hier_mess,
          ls_head   TYPE ttree,
          lt_titles TYPE TABLE OF ttreet,
          lt_nodes  TYPE TABLE OF hier_iface,
          lt_texts  TYPE TABLE OF hier_texts,
          lt_refs   TYPE TABLE OF hier_ref.

    io_xml->read( EXPORTING iv_name = 'TREE_HEAD'
                  CHANGING  cg_data = ls_head ).
    io_xml->read( EXPORTING iv_name = 'TREE_TITLES'
                  CHANGING  cg_data = lt_titles ).
    io_xml->read( EXPORTING iv_name = 'TREE_NODES'
                  CHANGING  cg_data = lt_nodes ).
    io_xml->read( EXPORTING iv_name = 'TREE_REFS'
                  CHANGING  cg_data = lt_refs ).
    io_xml->read( EXPORTING iv_name = 'TREE_TEXTS'
                  CHANGING  cg_data = lt_texts ).

    IF zif_abapgit_object~exists( ) = abap_true.
      delete_tree_structure( mv_tree_id ).
    ENDIF.

    CALL FUNCTION 'STREE_HIERARCHY_SAVE'
      EXPORTING
        structure_id             = mv_tree_id
        structure_type           = ls_head-type
        structure_description    = space
        structure_masterlanguage = mv_language
        structure_responsible    = sy-uname
        structure_buffermode     = ls_head-buffermode
        development_class        = iv_package
      IMPORTING
        message                  = ls_msg
      TABLES
        list_of_nodes            = lt_nodes
        list_of_references       = lt_refs
        list_of_texts            = lt_texts
        structure_descriptions   = lt_titles
      EXCEPTIONS
        no_nodes_given           = 1
        OTHERS                   = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from STREE_HIERARCHY_SAVE, SHI3' ).
    ENDIF.

  ENDMETHOD.