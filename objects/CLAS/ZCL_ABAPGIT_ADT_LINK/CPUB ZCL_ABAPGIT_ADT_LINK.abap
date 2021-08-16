CLASS zcl_abapgit_adt_link DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS generate
      IMPORTING
        !iv_obj_name     TYPE zif_abapgit_definitions=>ty_item-obj_name
        !iv_obj_type     TYPE zif_abapgit_definitions=>ty_item-obj_type
        !iv_sub_obj_name TYPE zif_abapgit_definitions=>ty_item-obj_name OPTIONAL
        !iv_line_number  TYPE i OPTIONAL
      RETURNING
        VALUE(rv_result) TYPE string
      RAISING
        zcx_abapgit_exception .