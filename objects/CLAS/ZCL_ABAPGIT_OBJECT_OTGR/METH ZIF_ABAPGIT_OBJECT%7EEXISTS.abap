  METHOD zif_abapgit_object~exists.
    rv_bool = cl_cls_object_type_group=>exists_object_type_group( ms_item-obj_name ).
  ENDMETHOD.