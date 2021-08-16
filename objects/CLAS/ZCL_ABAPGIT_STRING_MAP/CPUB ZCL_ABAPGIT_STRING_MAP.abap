CLASS zcl_abapgit_string_map DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_entry,
        k TYPE string,
        v TYPE string,
      END OF ty_entry.
    TYPES:
      tts_entries TYPE SORTED TABLE OF ty_entry WITH UNIQUE KEY k.

    CLASS-METHODS create
      RETURNING
        VALUE(ro_instance) TYPE REF TO zcl_abapgit_string_map.
    METHODS get
      IMPORTING
        iv_key        TYPE string
      RETURNING
        VALUE(rv_val) TYPE string.
    METHODS has
      IMPORTING
        iv_key        TYPE string
      RETURNING
        VALUE(rv_has) TYPE abap_bool.
    METHODS set
      IMPORTING
        iv_key TYPE string
        iv_val TYPE string OPTIONAL
      RETURNING
        VALUE(ro_map) TYPE REF TO zcl_abapgit_string_map
      RAISING
        zcx_abapgit_exception.
    METHODS size
      RETURNING
        VALUE(rv_size) TYPE i.
    METHODS is_empty
      RETURNING
        VALUE(rv_yes) TYPE abap_bool.
    METHODS delete
      IMPORTING
        iv_key TYPE string
      RAISING
        zcx_abapgit_exception.
    METHODS clear
      RAISING
        zcx_abapgit_exception.
    METHODS to_abap
      CHANGING
        !cs_container TYPE any
      RAISING
        zcx_abapgit_exception.
    METHODS freeze.

    DATA mt_entries TYPE tts_entries READ-ONLY.
