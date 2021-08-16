  METHOD zif_abapgit_object~serialize.

    DATA: ls_msg    TYPE hier_mess,
          ls_head   TYPE ttree,
          lt_titles TYPE TABLE OF ttreet,
          lt_nodes  TYPE TABLE OF hier_iface,
          lt_texts  TYPE TABLE OF hier_texts,
          lt_refs   TYPE TABLE OF hier_ref.


    CALL FUNCTION 'STREE_STRUCTURE_READ'
      EXPORTING
        structure_id     = mv_tree_id
      IMPORTING
        message          = ls_msg
        structure_header = ls_head
      TABLES
        description      = lt_titles.

    CALL FUNCTION 'STREE_HIERARCHY_READ'
      EXPORTING
        structure_id       = mv_tree_id
        read_also_texts    = 'X'
        all_languages      = 'X'
      IMPORTING
        message            = ls_msg
      TABLES
        list_of_nodes      = lt_nodes
        list_of_references = lt_refs
        list_of_texts      = lt_texts.

    clear_fields( CHANGING cs_head  = ls_head
                           ct_nodes = lt_nodes ).

    io_xml->add( iv_name = 'TREE_HEAD'
                 ig_data = ls_head ).
    io_xml->add( iv_name = 'TREE_TITLES'
                 ig_data = lt_titles ).
    io_xml->add( iv_name = 'TREE_NODES'
                 ig_data = lt_nodes ).
    io_xml->add( iv_name = 'TREE_REFS'
                 ig_data = lt_refs ).
    io_xml->add( iv_name = 'TREE_TEXTS'
                 ig_data = lt_texts ).

  ENDMETHOD.