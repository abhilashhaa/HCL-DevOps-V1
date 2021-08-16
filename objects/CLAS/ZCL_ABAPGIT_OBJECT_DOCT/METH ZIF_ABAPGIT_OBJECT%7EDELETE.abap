  METHOD zif_abapgit_object~delete.

    mi_longtexts->delete(
        iv_object_name = ms_item-obj_name
        iv_longtext_id = c_id ).

  ENDMETHOD.