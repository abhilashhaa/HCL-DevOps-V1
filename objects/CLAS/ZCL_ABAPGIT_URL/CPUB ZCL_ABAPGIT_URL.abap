CLASS zcl_abapgit_url DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS validate
      IMPORTING
        !iv_url TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS host
      IMPORTING
        !iv_url        TYPE string
      RETURNING
        VALUE(rv_host) TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS name
      IMPORTING
        !iv_url        TYPE string
        !iv_validate   TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rv_name) TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS path_name
      IMPORTING
        !iv_url             TYPE string
      RETURNING
        VALUE(rv_path_name) TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS is_abapgit_repo
      IMPORTING
        !iv_url           TYPE string
      RETURNING
        VALUE(rv_abapgit) TYPE abap_bool .