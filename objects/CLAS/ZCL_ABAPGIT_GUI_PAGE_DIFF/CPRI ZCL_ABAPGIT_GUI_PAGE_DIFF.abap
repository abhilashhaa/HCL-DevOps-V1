  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_actions,
        toggle_unified TYPE string VALUE 'toggle_unified',
      END OF c_actions .
    DATA mt_delayed_lines TYPE zif_abapgit_definitions=>ty_diffs_tt .
    DATA mv_repo_key TYPE zif_abapgit_persistence=>ty_repo-key .
    DATA mv_seed TYPE string .                    " Unique page id to bind JS sessionStorage

    METHODS render_diff
      IMPORTING
        !is_diff       TYPE ty_file_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_diff_head
      IMPORTING
        !is_diff       TYPE ty_file_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_table_head
      IMPORTING
        !is_diff       TYPE ty_file_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_beacon
      IMPORTING
        !is_diff_line  TYPE zif_abapgit_definitions=>ty_diff
        !is_diff       TYPE ty_file_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_line_split
      IMPORTING
        !is_diff_line  TYPE zif_abapgit_definitions=>ty_diff
        !iv_filename   TYPE string
        !iv_fstate     TYPE char1
        !iv_index      TYPE sy-tabix
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_line_unified
      IMPORTING
        !is_diff_line  TYPE zif_abapgit_definitions=>ty_diff OPTIONAL
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS append_diff
      IMPORTING
        !it_remote TYPE zif_abapgit_definitions=>ty_files_tt
        !it_local  TYPE zif_abapgit_definitions=>ty_files_item_tt
        !is_status TYPE zif_abapgit_definitions=>ty_result
      RAISING
        zcx_abapgit_exception .
    METHODS is_binary
      IMPORTING
        !iv_d1        TYPE xstring
        !iv_d2        TYPE xstring
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    METHODS add_jump_sub_menu
      IMPORTING
        !io_menu TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS add_filter_sub_menu
      IMPORTING
        !io_menu TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS render_lines
      IMPORTING
        !is_diff       TYPE ty_file_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_table_head_unified
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html .
    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS filter_diff_by_files
      IMPORTING
        !it_files      TYPE zif_abapgit_definitions=>ty_stage_tt
      CHANGING
        !ct_diff_files TYPE tt_file_diff .