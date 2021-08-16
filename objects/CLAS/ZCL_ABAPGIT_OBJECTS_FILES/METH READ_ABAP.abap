  METHOD read_abap.

    DATA: lv_filename TYPE string,
          lv_data     TYPE xstring,
          lv_abap     TYPE string.


    lv_filename = filename( iv_extra = iv_extra
                            iv_ext   = 'abap' ).

    lv_data = read_file( iv_filename = lv_filename
                         iv_error    = iv_error ).

    IF lv_data IS INITIAL. " Post-handling of iv_error = false
      RETURN.
    ENDIF.

    lv_abap = zcl_abapgit_convert=>xstring_to_string_utf8( lv_data ).

    SPLIT lv_abap AT zif_abapgit_definitions=>c_newline INTO TABLE rt_abap.

  ENDMETHOD.