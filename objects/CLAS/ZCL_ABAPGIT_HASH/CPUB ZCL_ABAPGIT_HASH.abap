CLASS zcl_abapgit_hash DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS adler32
      IMPORTING
        !iv_xstring        TYPE xstring
      RETURNING
        VALUE(rv_checksum) TYPE zif_abapgit_definitions=>ty_adler32 .
    CLASS-METHODS sha1
      IMPORTING
        !iv_type       TYPE zif_abapgit_definitions=>ty_type
        !iv_data       TYPE xstring
      RETURNING
        VALUE(rv_sha1) TYPE zif_abapgit_definitions=>ty_sha1
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS sha1_raw
      IMPORTING
        !iv_data       TYPE xstring
      RETURNING
        VALUE(rv_sha1) TYPE zif_abapgit_definitions=>ty_sha1
      RAISING
        zcx_abapgit_exception .