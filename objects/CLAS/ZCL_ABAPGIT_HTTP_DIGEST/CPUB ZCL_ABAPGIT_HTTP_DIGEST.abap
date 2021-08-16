CLASS zcl_abapgit_http_digest DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !ii_client   TYPE REF TO if_http_client
        !iv_username TYPE string
        !iv_password TYPE string
      RAISING
        zcx_abapgit_exception.
    METHODS run
      IMPORTING
        !ii_client TYPE REF TO if_http_client
      RAISING
        zcx_abapgit_exception.
