  METHOD zif_abapgit_object~deserialize.

    mi_longtexts->deserialize(
        iv_longtext_name   = c_name
        ii_xml             = io_xml
        iv_master_language = mv_language ).

    tadir_insert( iv_package ).

  ENDMETHOD.