CLASS zcl_abapgit_version DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS normalize
      IMPORTING
        !iv_version       TYPE string
      RETURNING
        VALUE(rv_version) TYPE string.

    CLASS-METHODS conv_str_to_version
      IMPORTING
        !iv_version       TYPE csequence
      RETURNING
        VALUE(rs_version) TYPE zif_abapgit_definitions=>ty_version
      RAISING
        zcx_abapgit_exception.

    CLASS-METHODS check_dependant_version
      IMPORTING
        !is_current   TYPE zif_abapgit_definitions=>ty_version
        !is_dependant TYPE zif_abapgit_definitions=>ty_version
      RAISING
        zcx_abapgit_exception.
