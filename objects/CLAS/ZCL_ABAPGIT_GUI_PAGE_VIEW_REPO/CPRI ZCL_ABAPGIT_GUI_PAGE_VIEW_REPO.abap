  PRIVATE SECTION.

    DATA mo_repo TYPE REF TO zcl_abapgit_repo .
    DATA mv_cur_dir TYPE string .
    DATA mv_hide_files TYPE abap_bool .
    DATA mv_max_lines TYPE i .
    DATA mv_max_setting TYPE i .
    DATA mv_show_folders TYPE abap_bool .
    DATA mv_changes_only TYPE abap_bool .
    DATA mv_order_by TYPE string .
    DATA mv_order_descending TYPE abap_bool .
    DATA mv_diff_first TYPE abap_bool .
    DATA mv_key TYPE zif_abapgit_persistence=>ty_value .
    DATA mv_are_changes_recorded_in_tr TYPE abap_bool .

    METHODS render_head_line
      IMPORTING
        !iv_lstate     TYPE char1
        !iv_rstate     TYPE char1
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS build_head_menu
      IMPORTING
        !iv_lstate        TYPE char1
        !iv_rstate        TYPE char1
      RETURNING
        VALUE(ro_toolbar) TYPE REF TO zcl_abapgit_html_toolbar
      RAISING
        zcx_abapgit_exception .
    METHODS build_view_menu
      RETURNING
        VALUE(ro_toolbar) TYPE REF TO zcl_abapgit_html_toolbar
      RAISING
        zcx_abapgit_exception .
    METHODS render_item
      IMPORTING
        !is_item              TYPE zif_abapgit_definitions=>ty_repo_item
        !iv_render_transports TYPE abap_bool
      RETURNING
        VALUE(ri_html)        TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_item_files
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_repo_item
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_item_command
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_repo_item
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS get_item_class
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_repo_item
      RETURNING
        VALUE(rv_html) TYPE string .
    METHODS get_item_icon
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_repo_item
      RETURNING
        VALUE(rv_html) TYPE string .
    METHODS render_item_lock_column
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_repo_item
      RETURNING
        VALUE(rv_html) TYPE string .
    METHODS render_parent_dir
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS build_obj_jump_link
      IMPORTING
        !is_item       TYPE zif_abapgit_definitions=>ty_repo_item
      RETURNING
        VALUE(rv_html) TYPE string .
    METHODS build_dir_jump_link
      IMPORTING
        !iv_path       TYPE string
      RETURNING
        VALUE(rv_html) TYPE string .
    METHODS build_inactive_object_code
      IMPORTING
        !is_item                     TYPE zif_abapgit_definitions=>ty_repo_item
      RETURNING
        VALUE(rv_inactive_html_code) TYPE string .
    METHODS open_in_master_language
      RAISING
        zcx_abapgit_exception .
    METHODS render_order_by
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS apply_order_by
      CHANGING
        !ct_repo_items TYPE zif_abapgit_definitions=>tt_repo_items .
    METHODS build_branch_dropdown
      IMPORTING
        !iv_wp_opt                LIKE zif_abapgit_html=>c_html_opt-crossout
      RETURNING
        VALUE(ro_branch_dropdown) TYPE REF TO zcl_abapgit_html_toolbar
      RAISING
        zcx_abapgit_exception .
    METHODS build_tag_dropdown
      IMPORTING
        !iv_wp_opt             LIKE zif_abapgit_html=>c_html_opt-crossout
      RETURNING
        VALUE(ro_tag_dropdown) TYPE REF TO zcl_abapgit_html_toolbar
      RAISING
        zcx_abapgit_exception .
    METHODS build_advanced_dropdown
      IMPORTING
        !iv_wp_opt                  LIKE zif_abapgit_html=>c_html_opt-crossout
        !iv_lstate                  TYPE char1
        !iv_rstate                  TYPE char1
      RETURNING
        VALUE(ro_advanced_dropdown) TYPE REF TO zcl_abapgit_html_toolbar
      RAISING
        zcx_abapgit_exception .
    METHODS build_main_toolbar
      IMPORTING
        !iv_pull_opt      LIKE zif_abapgit_html=>c_html_opt-crossout
        !iv_lstate        TYPE char1
        !iv_rstate        TYPE char1
        !io_tb_branch     TYPE REF TO zcl_abapgit_html_toolbar
        !io_tb_tag        TYPE REF TO zcl_abapgit_html_toolbar
        !io_tb_advanced   TYPE REF TO zcl_abapgit_html_toolbar
      RETURNING
        VALUE(ro_toolbar) TYPE REF TO zcl_abapgit_html_toolbar
      RAISING
        zcx_abapgit_exception .
    METHODS switch_to_pr
      IMPORTING
        !it_fields         TYPE tihttpnvp OPTIONAL
        !iv_revert         TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(rv_switched) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS build_main_menu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .