  METHOD read_global_settings_xml.

    rv_global_settings_xml = zcl_abapgit_persistence_db=>get_instance( )->read(
        iv_type  = zcl_abapgit_persistence_db=>c_type_settings
        iv_value = '' ).

  ENDMETHOD.