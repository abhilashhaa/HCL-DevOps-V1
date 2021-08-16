  METHOD serialize_sotr.
    mi_object_oriented_object_fct->read_sotr(
      iv_object_name = ms_item-obj_name
      ii_xml         = ii_xml ).
  ENDMETHOD.