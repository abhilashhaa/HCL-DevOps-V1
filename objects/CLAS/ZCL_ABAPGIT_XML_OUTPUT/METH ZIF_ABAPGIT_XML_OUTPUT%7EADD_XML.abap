  METHOD zif_abapgit_xml_output~add_xml.

    DATA: li_element TYPE REF TO if_ixml_element.

    li_element = mi_xml_doc->create_element( iv_name ).
    li_element->append_child( ii_xml ).

    mi_xml_doc->get_root( )->get_first_child( )->get_first_child( )->append_child( li_element ).

  ENDMETHOD.