CLASS zcl_abapgit_persistence_db DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.
    CONSTANTS c_tabname TYPE tabname VALUE 'ZABAPGIT' ##NO_TEXT.
    CONSTANTS c_lock TYPE viewname VALUE 'EZABAPGIT' ##NO_TEXT.

    CONSTANTS:
      c_type_settings   TYPE zif_abapgit_persistence=>ty_type VALUE 'SETTINGS' ##NO_TEXT,
      c_type_repo       TYPE zif_abapgit_persistence=>ty_type VALUE 'REPO' ##NO_TEXT,
      c_type_background TYPE zif_abapgit_persistence=>ty_type VALUE 'BACKGROUND' ##NO_TEXT,
      c_type_user       TYPE zif_abapgit_persistence=>ty_type VALUE 'USER' ##NO_TEXT.

    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_db) TYPE REF TO zcl_abapgit_persistence_db .
    METHODS add
      IMPORTING
        !iv_type  TYPE zif_abapgit_persistence=>ty_type
        !iv_value TYPE zif_abapgit_persistence=>ty_content-value
        !iv_data  TYPE zif_abapgit_persistence=>ty_content-data_str
      RAISING
        zcx_abapgit_exception .
    METHODS delete
      IMPORTING
        !iv_type  TYPE zif_abapgit_persistence=>ty_type
        !iv_value TYPE zif_abapgit_persistence=>ty_content-value
      RAISING
        zcx_abapgit_exception .
    METHODS list
      RETURNING
        VALUE(rt_content) TYPE zif_abapgit_persistence=>tt_content .
    METHODS list_by_type
      IMPORTING
        !iv_type          TYPE zif_abapgit_persistence=>ty_type
      RETURNING
        VALUE(rt_content) TYPE zif_abapgit_persistence=>tt_content .
    METHODS lock
      IMPORTING
        !iv_mode  TYPE enqmode DEFAULT 'E'
        !iv_type  TYPE zif_abapgit_persistence=>ty_type
        !iv_value TYPE zif_abapgit_persistence=>ty_content-value
      RAISING
        zcx_abapgit_exception .
    METHODS modify
      IMPORTING
        !iv_type  TYPE zif_abapgit_persistence=>ty_type
        !iv_value TYPE zif_abapgit_persistence=>ty_content-value
        !iv_data  TYPE zif_abapgit_persistence=>ty_content-data_str
      RAISING
        zcx_abapgit_exception .
    METHODS read
      IMPORTING
        !iv_type       TYPE zif_abapgit_persistence=>ty_type
        !iv_value      TYPE zif_abapgit_persistence=>ty_content-value
      RETURNING
        VALUE(rv_data) TYPE zif_abapgit_persistence=>ty_content-data_str
      RAISING
        zcx_abapgit_not_found .
    METHODS update
      IMPORTING
        !iv_type  TYPE zif_abapgit_persistence=>ty_type
        !iv_value TYPE zif_abapgit_persistence=>ty_content-value
        !iv_data  TYPE zif_abapgit_persistence=>ty_content-data_str
      RAISING
        zcx_abapgit_exception .