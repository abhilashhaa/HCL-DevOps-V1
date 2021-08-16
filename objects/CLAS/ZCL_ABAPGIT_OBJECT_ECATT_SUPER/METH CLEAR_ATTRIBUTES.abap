  METHOD clear_attributes.

    DATA: li_element     TYPE REF TO if_ixml_element,
          lv_object_type TYPE etobj_type.

    lv_object_type = get_object_type( ).

    li_element = ci_document->find_from_name( |{ lv_object_type }| ).
    li_element->remove_attribute( |SAPRL| ).
    li_element->remove_attribute( |DOWNLOADDATE| ).
    li_element->remove_attribute( |DOWNLOADTIME| ).

  ENDMETHOD.