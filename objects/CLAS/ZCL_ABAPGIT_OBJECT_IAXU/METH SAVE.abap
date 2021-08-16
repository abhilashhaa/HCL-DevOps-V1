  METHOD save.

    DATA: lo_xml_api TYPE REF TO object.

    lo_xml_api = w3_api_create_new( is_attr = is_attr ).

    w3_api_save( io_xml_api = lo_xml_api ).

    w3_api_set_changeable( io_xml_api    = lo_xml_api
                           iv_changeable = abap_false ).

  ENDMETHOD.