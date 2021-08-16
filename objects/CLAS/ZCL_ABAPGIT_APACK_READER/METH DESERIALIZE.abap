  METHOD deserialize.

    DATA: lv_xml  TYPE string,
          ls_data TYPE zif_abapgit_apack_definitions=>ty_descriptor.

    lv_xml = zcl_abapgit_convert=>xstring_to_string_utf8( iv_xstr ).

    ls_data = from_xml( lv_xml ).

    ro_manifest_reader = create_instance( iv_package_name ).

    ro_manifest_reader = create_instance( iv_package_name ).
    ro_manifest_reader->set_manifest_descriptor( ls_data ).

  ENDMETHOD.