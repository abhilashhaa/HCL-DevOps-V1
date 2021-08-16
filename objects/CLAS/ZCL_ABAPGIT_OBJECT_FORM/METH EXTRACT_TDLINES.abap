  METHOD extract_tdlines.

    DATA lv_string TYPE string.
    DATA li_xml TYPE REF TO zif_abapgit_xml_input.

    TRY.
        lv_string = mo_files->read_string( iv_extra =
                                   build_extra_from_header( is_form_data-form_header )
                                           iv_ext   = c_extension_xml ).
      CATCH zcx_abapgit_exception.

        lv_string = mo_files->read_string( iv_extra =
                               build_extra_from_header_old( is_form_data-form_header )
                                           iv_ext   = c_extension_xml ).

    ENDTRY.

    CREATE OBJECT li_xml TYPE zcl_abapgit_xml_input EXPORTING iv_xml = lv_string.
    li_xml->read( EXPORTING iv_name = c_objectname_tdlines
                  CHANGING  cg_data = rt_lines ).

  ENDMETHOD.