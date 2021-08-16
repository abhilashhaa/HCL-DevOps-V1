  METHOD to_xml.
* will render to codepage UTF-16

    DATA: li_ostream       TYPE REF TO if_ixml_ostream,
          li_renderer      TYPE REF TO if_ixml_renderer,
          lv_mark          TYPE string,
          li_streamfactory TYPE REF TO if_ixml_stream_factory.


    li_streamfactory = mi_ixml->create_stream_factory( ).

    li_ostream = li_streamfactory->create_ostream_cstring( rv_xml ).

    li_renderer = mi_ixml->create_renderer( ostream  = li_ostream
                                            document = mi_xml_doc ).
    li_renderer->set_normalizing( iv_normalize ).

    li_renderer->render( ).

    "unicode systems always add the byte order mark to the xml, while non-unicode does not
    "this code will always add the byte order mark if it is not in the xml
    lv_mark = zcl_abapgit_convert=>xstring_to_string_utf8( cl_abap_char_utilities=>byte_order_mark_utf8 ).
    IF rv_xml(1) <> lv_mark.
      CONCATENATE lv_mark rv_xml INTO rv_xml.
    ENDIF.

  ENDMETHOD.