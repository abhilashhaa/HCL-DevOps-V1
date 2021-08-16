CLASS zcl_abapgit_objects_files DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !is_item TYPE zif_abapgit_definitions=>ty_item
        !iv_path TYPE string OPTIONAL .
    METHODS add_string
      IMPORTING
        !iv_extra  TYPE clike OPTIONAL
        !iv_ext    TYPE string
        !iv_string TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS read_string
      IMPORTING
        !iv_extra        TYPE clike OPTIONAL
        !iv_ext          TYPE string
      RETURNING
        VALUE(rv_string) TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS add_xml
      IMPORTING
        !iv_extra     TYPE clike OPTIONAL
        !ii_xml       TYPE REF TO zif_abapgit_xml_output
        !iv_normalize TYPE abap_bool DEFAULT abap_true
        !is_metadata  TYPE zif_abapgit_definitions=>ty_metadata OPTIONAL
      RAISING
        zcx_abapgit_exception .
    METHODS read_xml
      IMPORTING
        !iv_extra     TYPE clike OPTIONAL
      RETURNING
        VALUE(ri_xml) TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS read_abap
      IMPORTING
        !iv_extra      TYPE clike OPTIONAL
        !iv_error      TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(rt_abap) TYPE abaptxt255_tab
      RAISING
        zcx_abapgit_exception .
    METHODS add_abap
      IMPORTING
        !iv_extra TYPE clike OPTIONAL
        !it_abap  TYPE STANDARD TABLE
      RAISING
        zcx_abapgit_exception .
    METHODS add
      IMPORTING
        !is_file TYPE zif_abapgit_definitions=>ty_file .
    METHODS add_raw
      IMPORTING
        !iv_extra TYPE clike OPTIONAL
        !iv_ext   TYPE string
        !iv_data  TYPE xstring
      RAISING
        zcx_abapgit_exception .
    METHODS read_raw
      IMPORTING
        !iv_extra      TYPE clike OPTIONAL
        !iv_ext        TYPE string
      RETURNING
        VALUE(rv_data) TYPE xstring
      RAISING
        zcx_abapgit_exception .
    METHODS get_files
      RETURNING
        VALUE(rt_files) TYPE zif_abapgit_definitions=>ty_files_tt .
    METHODS set_files
      IMPORTING
        !it_files TYPE zif_abapgit_definitions=>ty_files_tt .
    METHODS get_accessed_files
      RETURNING
        VALUE(rt_files) TYPE zif_abapgit_definitions=>ty_file_signatures_tt .
    METHODS contains
      IMPORTING
        !iv_extra         TYPE clike OPTIONAL
        !iv_ext           TYPE string
      RETURNING
        VALUE(rv_present) TYPE abap_bool.