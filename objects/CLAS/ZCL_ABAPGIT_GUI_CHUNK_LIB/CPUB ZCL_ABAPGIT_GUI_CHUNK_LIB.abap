CLASS zcl_abapgit_gui_chunk_lib DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_event_signature,
        method TYPE string,
        name   TYPE string,
      END OF  ty_event_signature .

    CLASS-METHODS class_constructor .
    CLASS-METHODS render_error
      IMPORTING
        !ix_error       TYPE REF TO zcx_abapgit_exception OPTIONAL
        !iv_error       TYPE string OPTIONAL
        !iv_extra_style TYPE string OPTIONAL
      RETURNING
        VALUE(ri_html)  TYPE REF TO zif_abapgit_html .
    CLASS-METHODS render_repo_top
      IMPORTING
        !io_repo               TYPE REF TO zcl_abapgit_repo
        !iv_show_package       TYPE abap_bool DEFAULT abap_true
        !iv_show_branch        TYPE abap_bool DEFAULT abap_true
        !iv_interactive_branch TYPE abap_bool DEFAULT abap_false
        !iv_branch             TYPE string OPTIONAL
        !io_news               TYPE REF TO zcl_abapgit_news OPTIONAL
      RETURNING
        VALUE(ri_html)         TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS render_item_state
      IMPORTING
        !iv_lstate     TYPE char1
        !iv_rstate     TYPE char1
      RETURNING
        VALUE(rv_html) TYPE string .
    CLASS-METHODS render_js_error_banner
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS render_news
      IMPORTING
        !io_news       TYPE REF TO zcl_abapgit_news
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS render_commit_popup
      IMPORTING
        !iv_content    TYPE csequence
        !iv_id         TYPE csequence
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS render_error_message_box
      IMPORTING
        !ix_error      TYPE REF TO zcx_abapgit_exception
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    CLASS-METHODS render_order_by_header_cells
      IMPORTING
        !it_col_spec         TYPE zif_abapgit_definitions=>tty_col_spec
        !iv_order_by         TYPE string
        !iv_order_descending TYPE abap_bool
      RETURNING
        VALUE(ri_html)       TYPE REF TO zif_abapgit_html .
    CLASS-METHODS render_warning_banner
      IMPORTING
        !iv_text       TYPE string
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    CLASS-METHODS render_infopanel
      IMPORTING
        !iv_div_id     TYPE string
        !iv_title      TYPE string
        !iv_hide       TYPE abap_bool DEFAULT abap_true
        !iv_hint       TYPE string OPTIONAL
        !iv_scrollable TYPE abap_bool DEFAULT abap_true
        !io_content    TYPE REF TO zif_abapgit_html
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS render_event_as_form
      IMPORTING
        !is_event      TYPE ty_event_signature
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    CLASS-METHODS render_repo_palette
      IMPORTING
        !iv_action     TYPE string
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS advanced_submenu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .
    CLASS-METHODS help_submenu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .