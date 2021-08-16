"! Provides checks for test environment
CLASS cl_ngc_test_environment DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS:
       gc_default_test_classtype             TYPE klassenart VALUE 'NGC'.
    METHODS:
      "! Checks if class type can be used for testing.
      "! For testing the class type should not be customized in the system in order to avoid side-effects.
      "! If the class type is available, the test will be aborted.
      "! @parameter iv_klart_test             | Class type to be checked
      precheck_class_type
        IMPORTING iv_klart_test TYPE klassenart,

      get_class_type_for_tests
        IMPORTING iv_classtype        TYPE klassenart DEFAULT cl_ngc_test_environment=>gc_default_test_classtype
        RETURNING VALUE(rv_classtype) TYPE klassenart.