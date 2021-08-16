  METHOD class_setup.
    lth_characteristic_handler=>create_characteristic( ).
    lth_class_data_handler=>create_classes( ).
    lth_material_handler=>create_materials( ).
    lth_classification_handler=>create_classification( ).
  ENDMETHOD.