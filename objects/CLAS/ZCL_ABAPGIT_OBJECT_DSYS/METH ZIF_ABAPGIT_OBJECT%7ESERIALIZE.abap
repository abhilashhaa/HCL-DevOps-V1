  METHOD zif_abapgit_object~serialize.

    zcl_abapgit_factory=>get_longtexts( )->serialize(
      iv_object_name = mv_doc_object
      iv_longtext_id = c_id
      ii_xml         = io_xml ).

  ENDMETHOD.