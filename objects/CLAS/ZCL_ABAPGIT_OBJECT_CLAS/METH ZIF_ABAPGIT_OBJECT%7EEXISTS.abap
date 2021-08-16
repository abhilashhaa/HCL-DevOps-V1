  METHOD zif_abapgit_object~exists.
    DATA: ls_class_key TYPE seoclskey.
    ls_class_key-clsname = ms_item-obj_name.

    rv_bool = mi_object_oriented_object_fct->exists( ls_class_key ).
  ENDMETHOD.