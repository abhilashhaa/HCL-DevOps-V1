CLASS zcl_abapgit_test_serialize DEFINITION
  PUBLIC
  CREATE PUBLIC
  FOR TESTING .

  PUBLIC SECTION.

    CLASS-METHODS check
      IMPORTING VALUE(is_item) TYPE zif_abapgit_definitions=>ty_item
      RAISING
                zcx_abapgit_exception .