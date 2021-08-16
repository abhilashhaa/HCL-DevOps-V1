  METHOD handle_attrib_leading_spaces.

    DATA li_element        TYPE REF TO if_ixml_element.
    DATA lv_leading_spaces TYPE string.
    DATA lv_coding_line    TYPE string.

    TRY.
        code_item_section_handling( EXPORTING iv_name                = iv_name
                                              ii_node                = ii_node
                                    IMPORTING ei_code_item_element   = li_element
                                    CHANGING  cv_within_code_section = cv_within_code_section ).

* for downwards compatibility, this code can be removed sometime in the future
        lv_leading_spaces = li_element->get_attribute_ns( name = attrib_abapgit_leadig_spaces ).

        lv_coding_line = li_element->get_value( ).
        IF strlen( lv_coding_line ) >= 1 AND lv_coding_line(1) <> | |.
          SHIFT lv_coding_line RIGHT BY lv_leading_spaces PLACES.
          li_element->set_value( lv_coding_line ).
        ENDIF.
      CATCH zcx_abapgit_exception ##no_handler.
    ENDTRY.

  ENDMETHOD.