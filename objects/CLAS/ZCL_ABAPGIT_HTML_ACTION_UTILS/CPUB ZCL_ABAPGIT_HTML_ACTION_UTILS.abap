CLASS zcl_abapgit_html_action_utils DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS parse_post_form_data
      IMPORTING
        !it_post_data TYPE cnht_post_data_tab
        !iv_upper_cased TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rt_fields) TYPE tihttpnvp .
    CLASS-METHODS parse_fields
      IMPORTING
        !iv_string       TYPE clike
      RETURNING
        VALUE(rt_fields) TYPE tihttpnvp .
    CLASS-METHODS parse_fields_upper_case_name
      IMPORTING
        !iv_string       TYPE clike
      RETURNING
        VALUE(rt_fields) TYPE tihttpnvp .
    CLASS-METHODS translate_postdata
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      RETURNING
        VALUE(rv_string) TYPE string .

    CLASS-METHODS get_field
      IMPORTING
        !iv_name   TYPE string
        !it_field  TYPE tihttpnvp
        !iv_decode TYPE abap_bool DEFAULT abap_false
      CHANGING
        !cg_field  TYPE any .
    CLASS-METHODS jump_encode
      IMPORTING
        !iv_obj_type     TYPE tadir-object
        !iv_obj_name     TYPE tadir-obj_name
      RETURNING
        VALUE(rv_string) TYPE string .
    CLASS-METHODS dir_encode
      IMPORTING
        !iv_path         TYPE string
      RETURNING
        VALUE(rv_string) TYPE string .

    CLASS-METHODS file_encode
      IMPORTING
        !iv_key          TYPE zif_abapgit_persistence=>ty_repo-key
        !ig_file         TYPE any
      RETURNING
        VALUE(rv_string) TYPE string .
    CLASS-METHODS obj_encode
      IMPORTING
        !iv_key          TYPE zif_abapgit_persistence=>ty_repo-key
        !ig_object       TYPE any
      RETURNING
        VALUE(rv_string) TYPE string .

    CLASS-METHODS dbkey_encode
      IMPORTING
        !is_key          TYPE zif_abapgit_persistence=>ty_content
      RETURNING
        VALUE(rv_string) TYPE string .
