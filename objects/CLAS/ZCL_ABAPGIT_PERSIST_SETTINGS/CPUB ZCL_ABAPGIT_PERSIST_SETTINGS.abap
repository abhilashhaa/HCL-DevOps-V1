CLASS zcl_abapgit_persist_settings DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.

    METHODS modify
      IMPORTING
        !io_settings TYPE REF TO zcl_abapgit_settings
      RAISING
        zcx_abapgit_exception .
    METHODS read
      RETURNING
        VALUE(ro_settings) TYPE REF TO zcl_abapgit_settings .
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_settings) TYPE REF TO zcl_abapgit_persist_settings .