  METHOD read_xml.

    DATA: lv_filename TYPE string,
          lv_data     TYPE xstring,
          lv_xml      TYPE string.

    lv_filename = filename( iv_extra = iv_extra
                            iv_ext   = 'xml' ).

    lv_data = read_file( lv_filename ).

    lv_xml = zcl_abapgit_convert=>xstring_to_string_utf8( lv_data ).

    CREATE OBJECT ri_xml
      TYPE zcl_abapgit_xml_input
      EXPORTING
        iv_xml      = lv_xml
        iv_filename = lv_filename.

  ENDMETHOD.