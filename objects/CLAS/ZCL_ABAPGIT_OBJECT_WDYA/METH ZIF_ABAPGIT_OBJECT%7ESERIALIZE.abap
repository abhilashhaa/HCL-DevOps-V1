  METHOD zif_abapgit_object~serialize.

    DATA: ls_app        TYPE wdy_application,
          lt_properties TYPE wdy_app_property_table.

    read( IMPORTING es_app        = ls_app
                    et_properties = lt_properties ).

    io_xml->add( iv_name = 'APP'
                 ig_data = ls_app ).
    io_xml->add( iv_name = 'PROPERTIES'
                 ig_data = lt_properties ).

    zcl_abapgit_sotr_handler=>read_sotr(
      iv_pgmid    = 'R3TR'
      iv_object   = ms_item-obj_type
      iv_obj_name = ms_item-obj_name
      io_xml      = io_xml ).

  ENDMETHOD.