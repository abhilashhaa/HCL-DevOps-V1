  METHOD escape_control_data.

    " Downport

    DATA: li_iter     TYPE REF TO if_ixml_node_iterator,
          li_textit   TYPE REF TO if_ixml_node_iterator,
          li_abapctrl TYPE REF TO if_ixml_node_collection,
          li_text     TYPE REF TO if_ixml_text,
          li_filter   TYPE REF TO if_ixml_node_filter,
          li_list     TYPE REF TO if_ixml_node_list,
          lv_value    TYPE etdom_name,
          li_vars     TYPE REF TO if_ixml_element,
          li_elem     TYPE REF TO if_ixml_element.

    li_vars = ii_element->find_from_name_ns( iv_tabname ).
    li_filter = ii_element->create_filter_node_type( if_ixml_node=>co_node_text ).
    IF li_vars IS NOT INITIAL.
      li_abapctrl = ii_element->get_elements_by_tag_name_ns( iv_node ).

* just for debugging
      li_iter = li_abapctrl->create_iterator( ).
      li_elem ?= li_iter->get_next( ).
      WHILE li_elem IS NOT INITIAL.
        li_list = li_elem->get_children( ).

        li_textit = li_list->create_rev_iterator_filtered( li_filter ).
        li_text ?= li_textit->get_next( ).
        IF li_text IS NOT INITIAL.
          lv_value = li_text->get_data( ).
          IF lv_value(1) = cl_abap_char_utilities=>minchar.
            REPLACE SECTION OFFSET 0 LENGTH 1 OF lv_value WITH space.
            li_text->set_value( value = lv_value ).
          ENDIF.
        ENDIF.
        CLEAR: li_textit, li_list, li_elem, lv_value.
        li_elem ?= li_iter->get_next( ).
      ENDWHILE.
      CLEAR: li_abapctrl, li_elem, li_iter.

    ENDIF.

  ENDMETHOD.