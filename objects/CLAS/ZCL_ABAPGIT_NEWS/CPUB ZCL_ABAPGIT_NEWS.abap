CLASS zcl_abapgit_news DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_log,
        version      TYPE string,
        pos_to_cur   TYPE i,
        is_header    TYPE abap_bool,
        is_important TYPE abap_bool,
        text         TYPE string,
      END OF ty_log .
    TYPES:
      tt_log TYPE STANDARD TABLE OF ty_log WITH DEFAULT KEY .

    CONSTANTS c_tail_length TYPE i VALUE 5 ##NO_TEXT.     " Number of versions to display if no updates

    CLASS-METHODS create     " TODO REFACTOR
      IMPORTING
        !io_repo           TYPE REF TO zcl_abapgit_repo
      RETURNING
        VALUE(ro_instance) TYPE REF TO zcl_abapgit_news
      RAISING
        zcx_abapgit_exception .
    METHODS get_log
      RETURNING
        VALUE(rt_log) TYPE tt_log .
    METHODS has_news
      RETURNING
        VALUE(rv_boolean) TYPE abap_bool .
    METHODS has_important
      RETURNING
        VALUE(rv_boolean) TYPE abap_bool .
    METHODS has_updates
      RETURNING
        VALUE(rv_boolean) TYPE abap_bool .
    METHODS has_unseen
      RETURNING
        VALUE(rv_boolean) TYPE abap_bool .
    METHODS constructor
      IMPORTING
        !iv_rawdata          TYPE xstring
        !iv_lastseen_version TYPE string
        !iv_current_version  TYPE string .