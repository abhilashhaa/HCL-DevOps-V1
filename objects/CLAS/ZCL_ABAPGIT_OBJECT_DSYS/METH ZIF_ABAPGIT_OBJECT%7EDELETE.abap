  METHOD zif_abapgit_object~delete.

    zcl_abapgit_factory=>get_longtexts( )->delete(
      iv_object_name = mv_doc_object
      iv_longtext_id = c_id ).

  ENDMETHOD.