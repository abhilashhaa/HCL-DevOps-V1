  METHOD add_xml.

    DATA: lv_xml  TYPE string,
          ls_file TYPE zif_abapgit_definitions=>ty_file.

    lv_xml = ii_xml->render( iv_normalize = iv_normalize
                             is_metadata = is_metadata ).
    ls_file-path = '/'.

    ls_file-filename = filename( iv_extra = iv_extra
                                 iv_ext   = 'xml' ).

    REPLACE FIRST OCCURRENCE
      OF REGEX '<\?xml version="1\.0" encoding="[\w-]+"\?>'
      IN lv_xml
      WITH '<?xml version="1.0" encoding="utf-8"?>'.
    ASSERT sy-subrc = 0.

    ls_file-data = zcl_abapgit_convert=>string_to_xstring_utf8_bom( lv_xml ).

    APPEND ls_file TO mt_files.
  ENDMETHOD.