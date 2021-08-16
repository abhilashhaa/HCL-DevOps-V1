  METHOD add_raw.

    DATA: ls_file TYPE zif_abapgit_definitions=>ty_file.

    ls_file-path     = '/'.
    ls_file-data     = iv_data.
    ls_file-filename = filename( iv_extra = iv_extra
                                 iv_ext   = iv_ext ).

    APPEND ls_file TO mt_files.

  ENDMETHOD.