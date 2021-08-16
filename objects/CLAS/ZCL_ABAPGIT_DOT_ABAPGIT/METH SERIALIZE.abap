  METHOD serialize.

    DATA: lv_xml  TYPE string,
          lv_mark TYPE string.

    lv_xml = to_xml( ms_data ).

    "unicode systems always add the byte order mark to the xml, while non-unicode does not
    "this code will always add the byte order mark if it is not in the xml
    lv_mark = zcl_abapgit_convert=>xstring_to_string_utf8( cl_abap_char_utilities=>byte_order_mark_utf8 ).
    IF lv_xml(1) <> lv_mark.
      CONCATENATE lv_mark lv_xml INTO lv_xml.
    ENDIF.

    rv_xstr = zcl_abapgit_convert=>string_to_xstring_utf8_bom( lv_xml ).

  ENDMETHOD.