CLASS zcl_abapgit_pr_enumerator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        io_repo TYPE REF TO zcl_abapgit_repo
      RAISING
        zcx_abapgit_exception.

    METHODS has_pulls
      RETURNING
        VALUE(rv_yes) TYPE abap_bool
      RAISING
        zcx_abapgit_exception.

    METHODS get_pulls
      RETURNING
        VALUE(rt_pulls) TYPE zif_abapgit_pr_enum_provider=>tty_pulls
      RAISING
        zcx_abapgit_exception.

    CLASS-METHODS new
      IMPORTING
        io_repo TYPE REF TO zcl_abapgit_repo
      RETURNING
        VALUE(ro_instance) TYPE REF TO zcl_abapgit_pr_enumerator
      RAISING
        zcx_abapgit_exception.
