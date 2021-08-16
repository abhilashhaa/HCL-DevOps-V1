  METHOD update_elements.

    DATA: lt_existing TYPE ty_elements,
          lt_add      TYPE scomeldata,
          lv_index    TYPE i,
          lv_found    TYPE abap_bool,
          ls_attr     TYPE scomeldtln.

    FIELD-SYMBOLS: <li_element> LIKE LINE OF lt_existing,
                   <ls_element> LIKE LINE OF is_pinf-elements.

    ii_interface->set_elements_changeable( abap_true ).

    lt_existing = ii_interface->get_elements( ).

    LOOP AT is_pinf-elements ASSIGNING <ls_element>.

      lv_found = abap_false.
      LOOP AT lt_existing ASSIGNING <li_element>.
        lv_index = sy-tabix.
        <li_element>->get_all_attributes( IMPORTING e_element_data = ls_attr ).
        IF <ls_element>-elem_type = ls_attr-elem_type
            AND <ls_element>-elem_key = ls_attr-elem_key.
          DELETE lt_existing INDEX lv_index.
          CONTINUE. " current loop
        ENDIF.
      ENDLOOP.

      IF lv_found = abap_false.
        APPEND <ls_element> TO lt_add.
      ENDIF.
    ENDLOOP.

    ii_interface->remove_elements( lt_existing ).

    ii_interface->add_elements( lt_add ).

    ii_interface->save_elements( ).

    ii_interface->set_elements_changeable( abap_false ).

  ENDMETHOD.