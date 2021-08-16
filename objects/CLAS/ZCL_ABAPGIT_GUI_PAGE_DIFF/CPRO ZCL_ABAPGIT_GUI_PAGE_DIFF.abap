  PROTECTED SECTION.

    DATA mv_unified TYPE abap_bool VALUE abap_true ##NO_TEXT.
    DATA mo_repo TYPE REF TO zcl_abapgit_repo .
    DATA mt_diff_files TYPE tt_file_diff .

    METHODS get_normalized_fname_with_path
      IMPORTING
        !is_diff           TYPE ty_file_diff
      RETURNING
        VALUE(rv_filename) TYPE string .
    METHODS normalize_path
      IMPORTING
        !iv_path             TYPE string
      RETURNING
        VALUE(rv_normalized) TYPE string .
    METHODS normalize_filename
      IMPORTING
        !iv_filename         TYPE string
      RETURNING
        VALUE(rv_normalized) TYPE string .
    METHODS add_menu_end
      IMPORTING
        !io_menu TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS calculate_diff
      IMPORTING
        !is_file   TYPE zif_abapgit_definitions=>ty_file OPTIONAL
        !is_object TYPE zif_abapgit_definitions=>ty_item OPTIONAL
        !it_files  TYPE zif_abapgit_definitions=>ty_stage_tt OPTIONAL
      RAISING
        zcx_abapgit_exception .
    METHODS add_menu_begin
      IMPORTING
        !io_menu TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS render_table_head_non_unified
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
        !is_diff TYPE ty_file_diff .
    METHODS render_beacon_begin_of_row
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
        !is_diff TYPE ty_file_diff .
    METHODS render_diff_head_after_state
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
        !is_diff TYPE ty_file_diff .
    METHODS insert_nav
      RETURNING
        VALUE(rv_insert_nav) TYPE abap_bool .
    METHODS render_line_split_row
      IMPORTING
        !ii_html      TYPE REF TO zif_abapgit_html
        !iv_filename  TYPE string
        !is_diff_line TYPE zif_abapgit_definitions=>ty_diff
        !iv_index     TYPE sy-tabix
        !iv_fstate    TYPE char1
        !iv_new       TYPE string
        !iv_old       TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS build_menu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .

    METHODS render_content
        REDEFINITION .