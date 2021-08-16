CLASS zcl_abapgit_dot_abapgit DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS build_default
      RETURNING
        VALUE(ro_dot_abapgit) TYPE REF TO zcl_abapgit_dot_abapgit .
    CLASS-METHODS deserialize
      IMPORTING
        !iv_xstr              TYPE xstring
      RETURNING
        VALUE(ro_dot_abapgit) TYPE REF TO zcl_abapgit_dot_abapgit
      RAISING
        zcx_abapgit_exception .
    METHODS constructor
      IMPORTING
        !is_data TYPE zif_abapgit_dot_abapgit=>ty_dot_abapgit .
    METHODS serialize
      RETURNING
        VALUE(rv_xstr) TYPE xstring
      RAISING
        zcx_abapgit_exception .
    METHODS get_data
      RETURNING
        VALUE(rs_data) TYPE zif_abapgit_dot_abapgit=>ty_dot_abapgit .
    METHODS add_ignore
      IMPORTING
        !iv_path     TYPE string
        !iv_filename TYPE string .
    METHODS is_ignored
      IMPORTING
        !iv_path          TYPE string
        !iv_filename      TYPE string
      RETURNING
        VALUE(rv_ignored) TYPE abap_bool .
    METHODS remove_ignore
      IMPORTING
        !iv_path     TYPE string
        !iv_filename TYPE string .
    METHODS get_starting_folder
      RETURNING
        VALUE(rv_path) TYPE string .

    METHODS get_folder_logic
      RETURNING
        VALUE(rv_logic) TYPE string .

    METHODS set_folder_logic
      IMPORTING
        !iv_logic TYPE string .

    METHODS set_starting_folder
      IMPORTING
        !iv_path TYPE string .

    METHODS get_master_language
      RETURNING
        VALUE(rv_language) TYPE spras .
*      set_master_language
*        IMPORTING iv_language TYPE spras,
    METHODS get_signature
      RETURNING
        VALUE(rs_signature) TYPE zif_abapgit_definitions=>ty_file_signature
      RAISING
        zcx_abapgit_exception .
    METHODS get_requirements
      RETURNING
        VALUE(rt_requirements) TYPE zif_abapgit_dot_abapgit=>ty_requirement_tt.
    METHODS set_requirements
      IMPORTING
        it_requirements TYPE zif_abapgit_dot_abapgit=>ty_requirement_tt.