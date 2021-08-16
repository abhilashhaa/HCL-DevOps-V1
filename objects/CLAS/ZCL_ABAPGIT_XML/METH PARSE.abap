  METHOD parse.

    DATA: li_stream_factory TYPE REF TO if_ixml_stream_factory,
          li_istream        TYPE REF TO if_ixml_istream,
          li_element        TYPE REF TO if_ixml_element,
          li_version        TYPE REF TO if_ixml_node,
          li_parser         TYPE REF TO if_ixml_parser.


    ASSERT NOT iv_xml IS INITIAL.

    li_stream_factory = mi_ixml->create_stream_factory( ).
    li_istream = li_stream_factory->create_istream_string( iv_xml ).
    li_parser = mi_ixml->create_parser( stream_factory = li_stream_factory
                                        istream        = li_istream
                                        document       = mi_xml_doc ).
    li_parser->add_strip_space_element( ).
    IF li_parser->parse( ) <> 0.
      error( li_parser ).
    ENDIF.

    li_istream->close( ).


    li_element = mi_xml_doc->find_from_name_ns( depth = 0
                                                name = c_abapgit_tag ).
    li_version = li_element->if_ixml_node~get_attributes(
      )->get_named_item_ns( c_attr_version ).
    IF li_version->get_value( ) <> zif_abapgit_version=>gc_xml_version.
      display_version_mismatch( ).
    ENDIF.

* buffer serializer metadata. Git node will be removed lateron
    ms_metadata-class   = li_element->get_attribute_ns( c_attr_serializer ).
    ms_metadata-version = li_element->get_attribute_ns( c_attr_serializer_version ).

  ENDMETHOD.