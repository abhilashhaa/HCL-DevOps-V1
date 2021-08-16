METHOD create_class_with_charcs.

  ASSERT is_class_header IS NOT INITIAL.

  ro_class = NEW cl_ngc_class(
    is_class_header                = is_class_header
    it_class_characteristics       = it_class_characteristics
    it_class_characteristic_values = it_class_characteristic_values
    it_characteristic_ref          = it_characteristic_ref ).

ENDMETHOD.