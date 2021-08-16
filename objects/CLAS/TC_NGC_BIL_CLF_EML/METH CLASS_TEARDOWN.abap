  METHOD class_teardown.
    lth_classification_handler=>remove_classification( ).
    lth_class_data_handler=>remove_classes( ).
    lth_characteristic_handler=>delete_characteristic( ).
  ENDMETHOD.