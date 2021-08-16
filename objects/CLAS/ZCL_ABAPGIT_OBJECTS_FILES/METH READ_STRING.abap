  METHOD read_string.

    DATA: lv_filename TYPE string,
          lv_data     TYPE xstring.

    lv_filename = filename( iv_extra = iv_extra
                            iv_ext   = iv_ext ).

    lv_data = read_file( lv_filename ).

    rv_string = zcl_abapgit_convert=>xstring_to_string_utf8( lv_data ).

  ENDMETHOD.