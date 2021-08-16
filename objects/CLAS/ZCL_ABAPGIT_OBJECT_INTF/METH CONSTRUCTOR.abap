  METHOD constructor.
    super->constructor(
      is_item     = is_item
      iv_language = iv_language ).
    mi_object_oriented_object_fct = zcl_abapgit_oo_factory=>make( ms_item-obj_type ).
  ENDMETHOD.