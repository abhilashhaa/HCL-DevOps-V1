  METHOD add_string.

    DATA: ls_file TYPE zif_abapgit_definitions=>ty_file.


    ls_file-path = '/'.
    ls_file-filename = filename( iv_extra = iv_extra
                                 iv_ext   = iv_ext ).
    ls_file-data = zcl_abapgit_convert=>string_to_xstring_utf8( iv_string ).

    APPEND ls_file TO mt_files.

  ENDMETHOD.