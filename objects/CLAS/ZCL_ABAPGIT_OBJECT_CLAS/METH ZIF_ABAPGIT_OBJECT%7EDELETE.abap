  METHOD zif_abapgit_object~delete.
    DATA: ls_clskey TYPE seoclskey.
    ls_clskey-clsname = ms_item-obj_name.

    mi_object_oriented_object_fct->delete( ls_clskey ).
  ENDMETHOD.