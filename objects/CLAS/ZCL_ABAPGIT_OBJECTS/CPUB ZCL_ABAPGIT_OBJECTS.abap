CLASS zcl_abapgit_objects DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      ty_types_tt TYPE SORTED TABLE OF tadir-object WITH UNIQUE KEY table_line.
    TYPES:
      BEGIN OF ty_serialization,
        files TYPE zif_abapgit_definitions=>ty_files_tt,
        item  TYPE zif_abapgit_definitions=>ty_item,
      END OF ty_serialization .

    CLASS-METHODS serialize
      IMPORTING
        !is_item                       TYPE zif_abapgit_definitions=>ty_item
        !iv_language                   TYPE spras
        !iv_serialize_master_lang_only TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rs_files_and_item)       TYPE ty_serialization
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS deserialize
      IMPORTING
        !io_repo                 TYPE REF TO zcl_abapgit_repo
        !is_checks               TYPE zif_abapgit_definitions=>ty_deserialize_checks
        !ii_log                  TYPE REF TO zif_abapgit_log
      RETURNING
        VALUE(rt_accessed_files) TYPE zif_abapgit_definitions=>ty_file_signatures_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS deserialize_checks
      IMPORTING
        !io_repo         TYPE REF TO zcl_abapgit_repo
      RETURNING
        VALUE(rs_checks) TYPE zif_abapgit_definitions=>ty_deserialize_checks
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS delete
      IMPORTING
        !it_tadir  TYPE zif_abapgit_definitions=>ty_tadir_tt
        !is_checks TYPE zif_abapgit_definitions=>ty_delete_checks OPTIONAL
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS jump
      IMPORTING
        !is_item        TYPE zif_abapgit_definitions=>ty_item
        !iv_line_number TYPE i OPTIONAL
        iv_sub_obj_name TYPE zif_abapgit_definitions=>ty_item-obj_name OPTIONAL
        iv_sub_obj_type TYPE zif_abapgit_definitions=>ty_item-obj_type OPTIONAL
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS changed_by
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_item
      RETURNING
        VALUE(rv_user) TYPE xubname
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS is_supported
      IMPORTING
        !is_item        TYPE zif_abapgit_definitions=>ty_item
        !iv_native_only TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rv_bool)  TYPE abap_bool .
    CLASS-METHODS exists
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_item
      RETURNING
        VALUE(rv_bool) TYPE abap_bool .
    CLASS-METHODS supported_list
      RETURNING
        VALUE(rt_types) TYPE ty_types_tt .
    CLASS-METHODS is_active
      IMPORTING
        !is_item         TYPE zif_abapgit_definitions=>ty_item
      RETURNING
        VALUE(rv_active) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .