  METHOD zif_abapgit_object~serialize.

    DATA: ls_pinf      TYPE ty_pinf,
          lt_elements  TYPE ty_elements,
          li_interface TYPE REF TO lif_package_interface_facade.

    FIELD-SYMBOLS: <lg_any>     TYPE any,
                   <li_element> LIKE LINE OF lt_elements,
                   <ls_element> LIKE LINE OF ls_pinf-elements.

    li_interface = load( |{ ms_item-obj_name }| ).

    ls_pinf-attributes = li_interface->get_all_attributes( ).

    "Delete the package name if it comes from the same package
    IF ls_pinf-attributes-tadir_devc = ls_pinf-attributes-pack_name.
      CLEAR ls_pinf-attributes-pack_name.
    ENDIF.

    CLEAR: ls_pinf-attributes-author,
           ls_pinf-attributes-created_by,
           ls_pinf-attributes-created_on,
           ls_pinf-attributes-changed_by,
           ls_pinf-attributes-changed_on,
           ls_pinf-attributes-tadir_devc.

* fields does not exist in older SAP versions
    ASSIGN COMPONENT 'SW_COMP_LOGICAL_PACKAGE' OF STRUCTURE ls_pinf-attributes TO <lg_any>.
    IF sy-subrc = 0.
      CLEAR <lg_any>.
    ENDIF.
    ASSIGN COMPONENT 'SW_COMP_TADIR_PACKAGE' OF STRUCTURE ls_pinf-attributes TO <lg_any>.
    IF sy-subrc = 0.
      CLEAR <lg_any>.
    ENDIF.

    lt_elements = li_interface->get_elements( ).

    LOOP AT lt_elements ASSIGNING <li_element>.
      APPEND INITIAL LINE TO ls_pinf-elements ASSIGNING <ls_element>.
      <li_element>->get_all_attributes( IMPORTING e_element_data = <ls_element> ).
      CLEAR <ls_element>-elem_pack.
    ENDLOOP.

    io_xml->add( ig_data = ls_pinf
                 iv_name = 'PINF' ).

  ENDMETHOD.