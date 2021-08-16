CLASS zcl_abapgit_proxy_auth DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      run
        IMPORTING ii_client TYPE REF TO if_http_client
        RAISING   zcx_abapgit_exception.
