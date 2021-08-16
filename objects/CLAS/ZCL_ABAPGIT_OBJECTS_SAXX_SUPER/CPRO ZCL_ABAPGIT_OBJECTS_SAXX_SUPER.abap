  PROTECTED SECTION.

    METHODS get_persistence_class_name
          ABSTRACT
      RETURNING
        VALUE(rv_persistence_class_name) TYPE seoclsname .
    METHODS get_data_class_name
          ABSTRACT
      RETURNING
        VALUE(rv_data_class_name) TYPE seoclsname .
    METHODS get_data_structure_name
          ABSTRACT
      RETURNING
        VALUE(rv_data_structure_name) TYPE string .