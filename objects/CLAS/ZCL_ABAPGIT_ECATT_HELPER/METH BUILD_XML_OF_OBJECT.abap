  METHOD build_xml_of_object.

    " downport of CL_APL_ECATT_DOWNLOAD=>BUILD_XML_OF_OBJECT

    DATA: lo_load_help_dummy TYPE REF TO cl_apl_ecatt_load_help,
          lx_ecatt           TYPE REF TO cx_ecatt_apl,
          lv_text            TYPE string,
          li_download        TYPE REF TO zif_abapgit_ecatt_download.

    "download method will create the xml stream
    "note: it's the redefined download( ) of each object type specific download, which is called
    TRY.
        CREATE OBJECT lo_load_help_dummy
          EXPORTING
            im_maintain_function = ''.

        io_download->download( im_object_name    = iv_object_name
                               im_object_version = iv_object_version
                               im_object_type    = iv_object_type
                               im_load_help      = lo_load_help_dummy ).

      CATCH cx_ecatt_apl INTO lx_ecatt.
        lv_text = lx_ecatt->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
        " note, exception cx_ecatt_ui_attachment doesn't exist in 702
      CATCH cx_ecatt.
        "will never be raised from download, when called with mv_generate_xml_no_download = 'X'.
    ENDTRY.

    li_download ?= io_download.

    rv_xml_stream = li_download->get_xml_stream( ).

  ENDMETHOD.