CLASS zcl_abapgit_apack_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS are_dependencies_met
      IMPORTING
        !it_dependencies TYPE zif_abapgit_apack_definitions=>tt_dependencies
      RETURNING
        VALUE(rv_status) TYPE zif_abapgit_definitions=>ty_yes_no
      RAISING
        zcx_abapgit_exception.

    CLASS-METHODS dependencies_popup
      IMPORTING
        !it_dependencies TYPE zif_abapgit_apack_definitions=>tt_dependencies
      RAISING
        zcx_abapgit_exception.
