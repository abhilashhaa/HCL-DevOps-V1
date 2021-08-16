  METHOD add_abap.

    DATA: lv_source TYPE string,
          ls_file   TYPE zif_abapgit_definitions=>ty_file.


    CONCATENATE LINES OF it_abap INTO lv_source SEPARATED BY zif_abapgit_definitions=>c_newline.
* when editing files via eg. GitHub web interface it adds a newline at end of file
    lv_source = lv_source && zif_abapgit_definitions=>c_newline.

    ls_file-path = '/'.
    ls_file-filename = filename( iv_extra = iv_extra
                                 iv_ext   = 'abap' ).
    ls_file-data = zcl_abapgit_convert=>string_to_xstring_utf8( lv_source ).

    APPEND ls_file TO mt_files.

  ENDMETHOD.