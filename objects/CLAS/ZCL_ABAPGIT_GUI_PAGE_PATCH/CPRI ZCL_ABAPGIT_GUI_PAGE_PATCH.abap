  PRIVATE SECTION.

    TYPES ty_patch_action TYPE string .

    CONSTANTS:
      BEGIN OF c_actions,
        stage                TYPE string VALUE 'patch_stage',
        refresh              TYPE string VALUE 'patch_refresh',
        refresh_local        TYPE string VALUE 'patch_refresh_local',
        refresh_local_object TYPE string VALUE 'patch_refresh_local_object',
      END OF c_actions .
    CONSTANTS:
      BEGIN OF c_patch_action,
        add    TYPE ty_patch_action VALUE 'add',
        remove TYPE ty_patch_action VALUE 'remove',
      END OF c_patch_action .
    DATA mo_stage TYPE REF TO zcl_abapgit_stage .
    DATA mv_section_count TYPE i .
    DATA mv_pushed TYPE abap_bool .
    DATA mo_repo_online TYPE REF TO zcl_abapgit_repo_online .

    METHODS render_patch
      IMPORTING
        !ii_html      TYPE REF TO zif_abapgit_html
        !iv_filename  TYPE string
        !is_diff_line TYPE zif_abapgit_definitions=>ty_diff
        !iv_index     TYPE sy-tabix
      RAISING
        zcx_abapgit_exception .
    METHODS render_patch_head
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
        !is_diff TYPE ty_file_diff .
    METHODS start_staging
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      RAISING
        zcx_abapgit_exception .
    METHODS apply_patch_from_form_fields
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      RAISING
        zcx_abapgit_exception .
    METHODS restore_patch_flags
      IMPORTING
        !it_diff_files_old TYPE tt_file_diff
      RAISING
        zcx_abapgit_exception .
    METHODS add_to_stage
      RAISING
        zcx_abapgit_exception .
    METHODS refresh
      IMPORTING
        !iv_action TYPE clike
      RAISING
        zcx_abapgit_exception .
    METHODS refresh_full
      RAISING
        zcx_abapgit_exception .
    METHODS refresh_local
      RAISING
        zcx_abapgit_exception .
    METHODS refresh_local_object
      IMPORTING
        !iv_action TYPE clike
      RAISING
        zcx_abapgit_exception .
    METHODS apply_patch_all
      IMPORTING
        !iv_patch      TYPE string
        !iv_patch_flag TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS are_all_lines_patched
      IMPORTING
        !it_diff                        TYPE zif_abapgit_definitions=>ty_diffs_tt
      RETURNING
        VALUE(rv_are_all_lines_patched) TYPE abap_bool .
    METHODS apply_patch_for
      IMPORTING
        !iv_filename   TYPE string
        !iv_line_index TYPE string
        !iv_patch_flag TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS get_diff_object
      IMPORTING
        !iv_filename   TYPE string
      RETURNING
        VALUE(ro_diff) TYPE REF TO zcl_abapgit_diff
      RAISING
        zcx_abapgit_exception .
    METHODS get_diff_line
      IMPORTING
        !io_diff       TYPE REF TO zcl_abapgit_diff
        !iv_line_index TYPE string
      RETURNING
        VALUE(rs_diff) TYPE zif_abapgit_definitions=>ty_diff
      RAISING
        zcx_abapgit_exception .
    METHODS is_every_changed_line_patched
      RETURNING
        VALUE(rv_everything_patched) TYPE abap_bool .
    CLASS-METHODS is_patch_line_possible
      IMPORTING
        !is_diff_line                    TYPE zif_abapgit_definitions=>ty_diff
      RETURNING
        VALUE(rv_is_patch_line_possible) TYPE abap_bool .
    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .