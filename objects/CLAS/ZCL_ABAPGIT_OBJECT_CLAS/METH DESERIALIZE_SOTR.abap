  METHOD deserialize_sotr.
    "OTR stands for Online Text Repository
    mi_object_oriented_object_fct->create_sotr(
      iv_object_name = ms_item-obj_name
      iv_package     = iv_package
      ii_xml         = ii_ml ).
  ENDMETHOD.