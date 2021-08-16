CLASS zcl_abapgit_git_utils DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES ty_null TYPE C LENGTH 1.
    CLASS-METHODS get_null
      RETURNING VALUE(rv_c) TYPE ty_null.

    CLASS-METHODS pkt_string
      IMPORTING iv_string     TYPE string
      RETURNING VALUE(rv_pkt) TYPE string
      RAISING   zcx_abapgit_exception.

    CLASS-METHODS length_utf8_hex
      IMPORTING iv_data       TYPE xstring
      RETURNING VALUE(rv_len) TYPE i
      RAISING   zcx_abapgit_exception.
