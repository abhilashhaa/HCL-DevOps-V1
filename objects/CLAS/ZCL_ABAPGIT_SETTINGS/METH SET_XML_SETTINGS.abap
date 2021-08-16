  METHOD set_xml_settings.

    DATA: lo_input TYPE REF TO zif_abapgit_xml_input.


    CREATE OBJECT lo_input TYPE zcl_abapgit_xml_input EXPORTING iv_xml = iv_settings_xml.

    CLEAR ms_settings.

    lo_input->read(
      EXPORTING
        iv_name = zcl_abapgit_persistence_db=>c_type_settings
      CHANGING
        cg_data = ms_settings ).

  ENDMETHOD.