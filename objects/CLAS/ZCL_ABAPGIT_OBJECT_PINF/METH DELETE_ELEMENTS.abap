  METHOD delete_elements.

    DATA: lt_elements TYPE ty_elements.

    FIELD-SYMBOLS: <li_element> LIKE LINE OF lt_elements.


    ii_interface->set_elements_changeable( abap_true ).

    lt_elements = ii_interface->get_elements( ).

    LOOP AT lt_elements ASSIGNING <li_element>.
      <li_element>->delete( ).
    ENDLOOP.

    ii_interface->save_elements( ).

  ENDMETHOD.