  METHOD get_property_from_xml.

    DATA(lo_xml) = NEW cl_xml_document( ).
    lo_xml->parse_string( iv_xml ).

    DATA(lo_root_node) = lo_xml->get_first_node( ).

    " Get entry
    DATA(lo_child) = lo_root_node->get_first_child( ).
    DATA(lv_name) = lo_child->get_name( ).

    WHILE lo_child IS NOT INITIAL AND
          lv_name <> 'entry'.
      lo_child = lo_child->get_next( ).
      CHECK lo_child IS NOT INITIAL.
      lv_name  = lo_child->get_name( ).
    ENDWHILE.

    CHECK lv_name = 'entry'.

    " Get content
    lo_child = lo_child->get_first_child( ).
    lv_name  = lo_child->get_name( ).

    WHILE lo_child IS NOT INITIAL AND
          lv_name <> 'content'.
      lo_child = lo_child->get_next( ).
      CHECK lo_child IS NOT INITIAL.
      lv_name  = lo_child->get_name( ).
    ENDWHILE.

    CHECK lv_name = 'content'.

    " Get m:properties
    lo_child = lo_child->get_first_child( ).
    CHECK lo_child IS NOT INITIAL.
    CHECK lv_name = 'm:properties'.

    " Get property
    lo_child = lo_child->get_first_child( ).
    CHECK lo_child IS NOT INITIAL.
    lv_name  = lo_child->get_name( ).

    WHILE lo_child IS NOT INITIAL AND
          lv_name <> iv_property_name.
      lo_child = lo_child->get_next( ).
      CHECK lo_child IS NOT INITIAL.
      lv_name  = lo_child->get_name( ).
    ENDWHILE.

    CHECK lv_name = iv_property_name.

    ev_value = lo_child->get_value( ).

  ENDMETHOD.