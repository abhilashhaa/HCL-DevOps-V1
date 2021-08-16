CLASS zcl_abapgit_utils DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS is_binary
      IMPORTING
        !iv_data      TYPE xstring
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    CLASS-METHODS extract_author_data
      IMPORTING
        !iv_author TYPE string
      EXPORTING
        !ev_author  TYPE zif_abapgit_definitions=>ty_commit-author
        !ev_email   TYPE zif_abapgit_definitions=>ty_commit-email
        !ev_time    TYPE zif_abapgit_definitions=>ty_commit-time
      RAISING
        zcx_abapgit_exception .