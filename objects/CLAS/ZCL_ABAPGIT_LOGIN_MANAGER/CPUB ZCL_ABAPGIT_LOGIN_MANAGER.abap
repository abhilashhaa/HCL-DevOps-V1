CLASS zcl_abapgit_login_manager DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS load
      IMPORTING
        !iv_uri                 TYPE string
        !ii_client              TYPE REF TO if_http_client OPTIONAL
      RETURNING
        VALUE(rv_authorization) TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS save
      IMPORTING
        !iv_uri    TYPE string
        !ii_client TYPE REF TO if_http_client
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS clear .
    CLASS-METHODS set
      IMPORTING
        !iv_uri        TYPE string
        !iv_username   TYPE string
        !iv_password   TYPE string
      RETURNING
        VALUE(rv_auth) TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get
      IMPORTING
        !iv_uri        TYPE string
      RETURNING
        VALUE(rv_auth) TYPE string
      RAISING
        zcx_abapgit_exception .