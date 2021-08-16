CLASS zcl_abapgit_stage DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS method_description
      IMPORTING
        !iv_method            TYPE zif_abapgit_definitions=>ty_method
      RETURNING
        VALUE(rv_description) TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS constructor
      IMPORTING
        !iv_merge_source TYPE zif_abapgit_definitions=>ty_sha1 OPTIONAL .
    METHODS add
      IMPORTING
        !iv_path     TYPE zif_abapgit_definitions=>ty_file-path
        !iv_filename TYPE zif_abapgit_definitions=>ty_file-filename
        !iv_data     TYPE xstring
        !is_status   TYPE zif_abapgit_definitions=>ty_result OPTIONAL
      RAISING
        zcx_abapgit_exception .
    METHODS reset
      IMPORTING
        !iv_path     TYPE zif_abapgit_definitions=>ty_file-path
        !iv_filename TYPE zif_abapgit_definitions=>ty_file-filename
      RAISING
        zcx_abapgit_exception .
    METHODS rm
      IMPORTING
        !iv_path     TYPE zif_abapgit_definitions=>ty_file-path
        !iv_filename TYPE zif_abapgit_definitions=>ty_file-filename
        !is_status   TYPE zif_abapgit_definitions=>ty_result OPTIONAL
      RAISING
        zcx_abapgit_exception .
    METHODS ignore
      IMPORTING
        !iv_path     TYPE zif_abapgit_definitions=>ty_file-path
        !iv_filename TYPE zif_abapgit_definitions=>ty_file-filename
      RAISING
        zcx_abapgit_exception .
    METHODS get_merge_source
      RETURNING
        VALUE(rv_source) TYPE zif_abapgit_definitions=>ty_sha1 .
    METHODS count
      RETURNING
        VALUE(rv_count) TYPE i .
    METHODS get_all
      RETURNING
        VALUE(rt_stage) TYPE zif_abapgit_definitions=>ty_stage_tt .