  METHOD clear_element.

    DATA: li_element TYPE REF TO if_ixml_element.

    li_element = ci_document->find_from_name( iv_name ).

    IF li_element IS BOUND.
      li_element->set_value( || ).
    ENDIF.

  ENDMETHOD.