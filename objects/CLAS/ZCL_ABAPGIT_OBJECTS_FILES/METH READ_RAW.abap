  METHOD read_raw.

    DATA: lv_filename TYPE string.

    lv_filename = filename( iv_extra = iv_extra
                            iv_ext   = iv_ext ).

    rv_data = read_file( lv_filename ).

  ENDMETHOD.