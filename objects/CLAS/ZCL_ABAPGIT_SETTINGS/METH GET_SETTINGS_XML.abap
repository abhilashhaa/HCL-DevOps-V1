  METHOD get_settings_xml.

    DATA: li_output TYPE REF TO zif_abapgit_xml_output.


    CREATE OBJECT li_output TYPE zcl_abapgit_xml_output.

    li_output->add( iv_name = zcl_abapgit_persistence_db=>c_type_settings
                    ig_data = ms_settings ).

    rv_settings_xml = li_output->render( ).

  ENDMETHOD.