  METHOD zif_abapgit_object~serialize.

    mi_longtexts->serialize(
        iv_longtext_name = c_name
        iv_object_name = ms_item-obj_name
        iv_longtext_id = c_id
        ii_xml         = io_xml ).

  ENDMETHOD.