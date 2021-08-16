  METHOD zif_abapgit_object~jump.

    zcl_abapgit_objects_super=>jump_adt(
        iv_obj_name = ms_item-obj_name
        iv_obj_type = ms_item-obj_type ).

  ENDMETHOD.