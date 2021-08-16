  METHOD zif_abapgit_object~changed_by.

    rv_user = zcl_abapgit_factory=>get_longtexts( )->changed_by(
      iv_object_name = mv_doc_object
      iv_longtext_id = c_id ).

  ENDMETHOD.