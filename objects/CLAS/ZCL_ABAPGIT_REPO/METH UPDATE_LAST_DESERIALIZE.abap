  METHOD update_last_deserialize.

    DATA: lv_deserialized_at TYPE zif_abapgit_persistence=>ty_repo-deserialized_at,
          lv_deserialized_by TYPE zif_abapgit_persistence=>ty_repo-deserialized_by.

    GET TIME STAMP FIELD lv_deserialized_at.
    lv_deserialized_by = sy-uname.

    set( iv_deserialized_at = lv_deserialized_at
         iv_deserialized_by = lv_deserialized_by ).

  ENDMETHOD.