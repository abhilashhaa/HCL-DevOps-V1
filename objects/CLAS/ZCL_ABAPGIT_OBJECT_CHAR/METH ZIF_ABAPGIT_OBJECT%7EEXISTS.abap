  METHOD zif_abapgit_object~exists.

    rv_bool = cl_cls_attribute=>exists_object_attribute( ms_item-obj_name ).

  ENDMETHOD.