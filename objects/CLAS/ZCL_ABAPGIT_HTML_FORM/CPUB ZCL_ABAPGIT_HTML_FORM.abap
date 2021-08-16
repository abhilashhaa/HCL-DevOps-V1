CLASS zcl_abapgit_html_form DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS create
      IMPORTING
        iv_form_id     TYPE string OPTIONAL
      RETURNING
        VALUE(ro_form) TYPE REF TO zcl_abapgit_html_form.

    METHODS render
      IMPORTING
        iv_form_class     TYPE string
        io_values         TYPE REF TO zcl_abapgit_string_map
        io_validation_log TYPE REF TO zcl_abapgit_string_map OPTIONAL
      RETURNING
        VALUE(ri_html)    TYPE REF TO zif_abapgit_html.

    METHODS command
      IMPORTING
        iv_label   TYPE string
        iv_action  TYPE string
        iv_is_main TYPE abap_bool DEFAULT abap_false
        iv_as_a    TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(ro_self) TYPE REF TO zcl_abapgit_html_form.

    METHODS text
      IMPORTING
        iv_label       TYPE string
        iv_name        TYPE string
        iv_hint        TYPE string OPTIONAL
        iv_required    TYPE abap_bool DEFAULT abap_false
        iv_upper_case  TYPE abap_bool DEFAULT abap_false
        iv_placeholder TYPE string OPTIONAL
        iv_side_action TYPE string OPTIONAL
      RETURNING
        VALUE(ro_self) TYPE REF TO zcl_abapgit_html_form.

    METHODS checkbox
      IMPORTING
        iv_label TYPE string
        iv_name  TYPE string
        iv_hint  TYPE string OPTIONAL
      RETURNING
        VALUE(ro_self) TYPE REF TO zcl_abapgit_html_form.

    METHODS radio
      IMPORTING
        iv_label         TYPE string
        iv_name          TYPE string
        iv_default_value TYPE string OPTIONAL
        iv_hint          TYPE string OPTIONAL
      RETURNING
        VALUE(ro_self) TYPE REF TO zcl_abapgit_html_form.

    METHODS option
      IMPORTING
        iv_label TYPE string
        iv_value TYPE string
      RETURNING
        VALUE(ro_self) TYPE REF TO zcl_abapgit_html_form.

    METHODS start_group
      IMPORTING
        iv_label TYPE string
        iv_name  TYPE string
        iv_hint  TYPE string OPTIONAL
      RETURNING
        VALUE(ro_self) TYPE REF TO zcl_abapgit_html_form.

    METHODS validate_normalize_form_data
      IMPORTING
        io_form_data TYPE REF TO zcl_abapgit_string_map
      RETURNING
        VALUE(ro_form_data) TYPE REF TO zcl_abapgit_string_map
      RAISING
        zcx_abapgit_exception.
