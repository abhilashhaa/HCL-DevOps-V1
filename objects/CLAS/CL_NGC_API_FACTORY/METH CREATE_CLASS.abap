METHOD create_class.

  ASSERT is_class_header IS NOT INITIAL.

  ro_class = NEW cl_ngc_class( is_class_header = is_class_header ).

ENDMETHOD.