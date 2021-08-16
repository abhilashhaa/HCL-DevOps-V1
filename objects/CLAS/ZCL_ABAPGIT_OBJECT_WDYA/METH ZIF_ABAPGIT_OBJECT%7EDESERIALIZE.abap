  METHOD zif_abapgit_object~deserialize.

    DATA: ls_app        TYPE wdy_application,
          lt_properties TYPE wdy_app_property_table.

    io_xml->read( EXPORTING iv_name = 'APP'
                  CHANGING cg_data = ls_app ).
    io_xml->read( EXPORTING iv_name = 'PROPERTIES'
                  CHANGING cg_data = lt_properties ).

    save( is_app        = ls_app
          it_properties = lt_properties
          iv_package    = iv_package ).

    zcl_abapgit_sotr_handler=>create_sotr(
      iv_package = iv_package
      io_xml     = io_xml ).

  ENDMETHOD.