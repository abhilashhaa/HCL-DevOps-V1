  METHOD zif_abapgit_object~serialize.

    DATA: lv_xstr     TYPE xstring,
          li_document TYPE REF TO if_ixml_document.


    lv_xstr = form_to_xstring( ).
    li_document = cl_ixml_80_20=>parse_to_document( stream_xstring = lv_xstr ).
    fix_oref( li_document ).
    io_xml->set_raw( li_document->get_root_element( ) ).

  ENDMETHOD.