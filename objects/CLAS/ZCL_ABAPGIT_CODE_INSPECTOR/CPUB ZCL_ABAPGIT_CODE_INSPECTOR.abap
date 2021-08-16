CLASS zcl_abapgit_code_inspector DEFINITION
  PUBLIC
  CREATE PROTECTED
  GLOBAL FRIENDS zcl_abapgit_factory .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_code_inspector .

    METHODS constructor
      IMPORTING
        !iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS validate_check_variant
      IMPORTING
        !iv_check_variant_name TYPE sci_chkv
      RAISING
        zcx_abapgit_exception .