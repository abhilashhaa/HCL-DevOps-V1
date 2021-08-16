  METHOD serialize_longtexts.

    zcl_abapgit_factory=>get_longtexts( )->serialize(
        iv_object_name = ms_item-obj_name
        iv_longtext_id = iv_longtext_id
        it_dokil       = it_dokil
        ii_xml         = ii_xml  ).

  ENDMETHOD.