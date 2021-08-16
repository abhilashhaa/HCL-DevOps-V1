  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_file_diff,
        path       TYPE string,
        filename   TYPE string,
        lstate     TYPE char1,
        rstate     TYPE char1,
        fstate     TYPE char1, " FILE state - Abstraction for shorter ifs
        o_diff     TYPE REF TO zcl_abapgit_diff,
        changed_by TYPE xubname,
        type       TYPE string,
      END OF ty_file_diff .

    CONSTANTS:
      BEGIN OF c_actions,
        toggle_mode  TYPE string VALUE 'toggle_mode' ##NO_TEXT,
        apply_merge  TYPE string VALUE 'apply_merge' ##NO_TEXT,
        apply_source TYPE string VALUE 'apply_source' ##NO_TEXT,
        apply_target TYPE string VALUE 'apply_target' ##NO_TEXT,
        cancel       TYPE string VALUE 'cancel' ##NO_TEXT,
      END OF c_actions .
    CONSTANTS:
      BEGIN OF c_merge_mode,
        selection TYPE string VALUE 'selection' ##NO_TEXT,
        merge     TYPE string VALUE 'merge' ##NO_TEXT,
      END OF c_merge_mode .
    DATA mo_merge TYPE REF TO zcl_abapgit_merge .
    DATA mo_merge_page TYPE REF TO zcl_abapgit_gui_page_merge .
    DATA mo_repo TYPE REF TO zcl_abapgit_repo_online .
    DATA ms_diff_file TYPE ty_file_diff .
    DATA mv_current_conflict_index TYPE sy-tabix .
    DATA mv_merge_mode TYPE string .
    DATA mt_conflicts TYPE zif_abapgit_definitions=>tt_merge_conflict .

    METHODS apply_merged_content
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      RAISING
        zcx_abapgit_exception .
    METHODS build_menu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS is_binary
      IMPORTING
        !iv_d1        TYPE xstring
        !iv_d2        TYPE xstring
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    METHODS render_beacon
      IMPORTING
        !is_diff_line  TYPE zif_abapgit_definitions=>ty_diff
        !is_diff       TYPE ty_file_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
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
    METHODS render_lines
      IMPORTING
        !is_diff       TYPE ty_file_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_line_split
      IMPORTING
        !is_diff_line  TYPE zif_abapgit_definitions=>ty_diff
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_table_head
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS resolve_diff
      RAISING
        zcx_abapgit_exception .
    METHODS toggle_merge_mode .