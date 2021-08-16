  METHOD get_global_settings_document.

    DATA: lv_global_settings_xml TYPE string.

    lv_global_settings_xml = read_global_settings_xml( ).

    ri_global_settings_dom = cl_ixml_80_20=>parse_to_document( stream_string = lv_global_settings_xml ).

  ENDMETHOD.