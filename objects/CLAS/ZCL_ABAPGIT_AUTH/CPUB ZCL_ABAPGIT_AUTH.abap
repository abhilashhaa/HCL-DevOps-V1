CLASS zcl_abapgit_auth DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS:
      is_allowed
        IMPORTING iv_authorization  TYPE zif_abapgit_auth=>ty_authorization
                  iv_param          TYPE string OPTIONAL
        RETURNING VALUE(rv_allowed) TYPE abap_bool.
