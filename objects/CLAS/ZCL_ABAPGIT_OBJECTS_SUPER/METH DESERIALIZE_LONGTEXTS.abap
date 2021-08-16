  METHOD deserialize_longtexts.

    zcl_abapgit_factory=>get_longtexts( )->deserialize(
        ii_xml             = ii_xml
        iv_master_language = mv_language ).

  ENDMETHOD.