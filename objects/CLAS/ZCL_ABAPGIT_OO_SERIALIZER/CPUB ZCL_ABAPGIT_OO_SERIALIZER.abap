CLASS zcl_abapgit_oo_serializer DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS serialize_abap_clif_source
      IMPORTING
        !is_class_key    TYPE seoclskey
      RETURNING
        VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING
        zcx_abapgit_exception
        cx_sy_dyn_call_error .
    METHODS are_test_classes_skipped
      RETURNING
        VALUE(rv_return) TYPE abap_bool .
    METHODS serialize_locals_imp
      IMPORTING
        !is_clskey       TYPE seoclskey
      RETURNING
        VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_locals_def
      IMPORTING
        !is_clskey       TYPE seoclskey
      RETURNING
        VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_testclasses
      IMPORTING
        !is_clskey       TYPE seoclskey
      RETURNING
        VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_macros
      IMPORTING
        !is_clskey       TYPE seoclskey
      RETURNING
        VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING
        zcx_abapgit_exception .