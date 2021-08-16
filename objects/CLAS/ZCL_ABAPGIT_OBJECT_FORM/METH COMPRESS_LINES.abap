  METHOD compress_lines.

    DATA lv_string TYPE string.
    DATA li_xml TYPE REF TO zif_abapgit_xml_output.

    CREATE OBJECT li_xml TYPE zcl_abapgit_xml_output.
    li_xml->add( iv_name = c_objectname_tdlines
                 ig_data = it_lines ).
    lv_string = li_xml->render( ).
    IF lv_string IS NOT INITIAL.
      mo_files->add_string( iv_extra  =
                    build_extra_from_header( is_form_data-form_header )
                            iv_ext    = c_extension_xml
                            iv_string = lv_string ).
    ENDIF.

  ENDMETHOD.