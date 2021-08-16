  METHOD fix_ids.

    " makes sure ID and IDREF values are the same values for each serialization run
    " the standard code has a counter that keeps increasing values.
    "
    " It is important that IDs and IDREFs which are the same before the fix
    " are also the same after the fix.

    TYPES:
      BEGIN OF ty_id_mapping,
        old TYPE string,
        new TYPE string,
      END OF ty_id_mapping,
      tty_id_mapping TYPE HASHED TABLE OF ty_id_mapping
                          WITH UNIQUE KEY old.

    DATA: lv_name       TYPE string,
          li_idref      TYPE REF TO if_ixml_node,
          li_node       TYPE REF TO if_ixml_node,
          li_attr       TYPE REF TO if_ixml_named_node_map,
          li_iterator   TYPE REF TO if_ixml_node_iterator,
          lt_id_mapping TYPE tty_id_mapping,
          ls_id_mapping LIKE LINE OF lt_id_mapping.

    li_iterator = ii_xml_doc->create_iterator( ).
    li_node = li_iterator->get_next( ).
    WHILE NOT li_node IS INITIAL.
      lv_name = li_node->get_name( ).
      IF lv_name = 'NODE' OR lv_name = 'WINDOW'.
        li_idref = li_node->get_attributes( )->get_named_item( 'IDREF' ).
        IF li_idref IS BOUND.

          ls_id_mapping-old = li_idref->get_value( ).
          READ TABLE lt_id_mapping WITH KEY old = ls_id_mapping-old
                                   INTO ls_id_mapping.
          IF sy-subrc <> 0.
            lv_name = lines( lt_id_mapping ) + 1.
            ls_id_mapping-new = condense( lv_name ).
            INSERT ls_id_mapping INTO TABLE lt_id_mapping.
          ENDIF.

          li_idref->set_value( |{ ls_id_mapping-new }| ).
        ENDIF.
      ENDIF.
      li_node = li_iterator->get_next( ).
    ENDWHILE.

    li_iterator = ii_xml_doc->create_iterator( ).
    li_node = li_iterator->get_next( ).
    WHILE NOT li_node IS INITIAL.
      lv_name = li_node->get_name( ).
      IF lv_name = 'NODE' OR lv_name = 'WINDOW'.
        li_idref = li_node->get_attributes( )->get_named_item( 'ID' ).
        IF li_idref IS BOUND.

          ls_id_mapping-old = li_idref->get_value( ).
          READ TABLE lt_id_mapping WITH KEY old = ls_id_mapping-old
                                   INTO ls_id_mapping.
          IF sy-subrc = 0.
            li_idref->set_value( |{ ls_id_mapping-new }| ).
          ELSE.
            li_attr = li_node->get_attributes( ).
            li_attr->remove_named_item( 'ID' ).
          ENDIF.

        ENDIF.
      ENDIF.
      li_node = li_iterator->get_next( ).
    ENDWHILE.

  ENDMETHOD.