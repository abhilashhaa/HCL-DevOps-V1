  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_changed_by,
        item TYPE zif_abapgit_definitions=>ty_item,
        name TYPE xubname,
      END OF ty_changed_by .
    TYPES:
      ty_changed_by_tt TYPE SORTED TABLE OF ty_changed_by WITH UNIQUE KEY item .
    TYPES:
      BEGIN OF ty_transport,
        item      TYPE zif_abapgit_definitions=>ty_item,
        transport TYPE trkorr,
      END OF ty_transport .
    TYPES:
      ty_transport_tt TYPE SORTED TABLE OF ty_transport WITH UNIQUE KEY item .

    DATA mo_repo TYPE REF TO zcl_abapgit_repo_online .
    DATA ms_files TYPE zif_abapgit_definitions=>ty_stage_files .
    DATA mv_seed TYPE string .             " Unique page id to bind JS sessionStorage
    DATA mv_filter_value TYPE string .

    METHODS find_changed_by
      IMPORTING
        !it_local            TYPE zif_abapgit_definitions=>ty_files_item_tt
      RETURNING
        VALUE(rt_changed_by) TYPE ty_changed_by_tt .
    METHODS find_transports
      IMPORTING
        !it_local            TYPE zif_abapgit_definitions=>ty_files_item_tt
      RETURNING
        VALUE(rt_transports) TYPE ty_transport_tt .
    METHODS render_list
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_file
      IMPORTING
        !iv_context    TYPE string
        !is_file       TYPE zif_abapgit_definitions=>ty_file
        !is_item       TYPE zif_abapgit_definitions=>ty_item OPTIONAL
        !is_status     TYPE zif_abapgit_definitions=>ty_result
        !iv_changed_by TYPE xubname OPTIONAL
        !iv_transport  TYPE trkorr OPTIONAL
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_actions
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS stage_selected
      IMPORTING
        !it_postdata    TYPE cnht_post_data_tab
      RETURNING
        VALUE(ro_stage) TYPE REF TO zcl_abapgit_stage
      RAISING
        zcx_abapgit_exception .
    METHODS stage_all
      RETURNING
        VALUE(ro_stage) TYPE REF TO zcl_abapgit_stage
      RAISING
        zcx_abapgit_exception .
    METHODS build_menu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS get_page_patch
      IMPORTING
        !io_stage      TYPE REF TO zcl_abapgit_stage
      RETURNING
        VALUE(ri_page) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception .
    METHODS render_master_language_warning
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS count_default_files_to_commit
      RETURNING
        VALUE(rv_count) TYPE i .
    METHODS render_deferred_hidden_events
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .