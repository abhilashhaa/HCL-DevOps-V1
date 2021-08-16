  METHOD delete_longtexts.

    zcl_abapgit_factory=>get_longtexts( )->delete(
        iv_longtext_id = iv_longtext_id
        iv_object_name = ms_item-obj_name  ).

  ENDMETHOD.