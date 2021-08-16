  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_page_stack,
        page     TYPE REF TO zif_abapgit_gui_renderable,
        bookmark TYPE abap_bool,
      END OF ty_page_stack .

    DATA mv_rollback_on_error TYPE abap_bool .
    DATA mi_cur_page TYPE REF TO zif_abapgit_gui_renderable .
    DATA:
      mt_stack             TYPE STANDARD TABLE OF ty_page_stack .
    DATA:
      mt_event_handlers    TYPE STANDARD TABLE OF REF TO zif_abapgit_gui_event_handler .
    DATA mi_router TYPE REF TO zif_abapgit_gui_event_handler .
    DATA mi_asset_man TYPE REF TO zif_abapgit_gui_asset_manager .
    DATA mi_hotkey_ctl TYPE REF TO zif_abapgit_gui_hotkey_ctl .
    DATA mi_html_processor TYPE REF TO zif_abapgit_gui_html_processor .
    DATA mi_html_viewer TYPE REF TO zif_abapgit_html_viewer .
    DATA mo_html_parts TYPE REF TO zcl_abapgit_html_parts .

    METHODS cache_html
      IMPORTING
        !iv_text      TYPE string
      RETURNING
        VALUE(rv_url) TYPE w3url .
    METHODS startup
      RAISING
        zcx_abapgit_exception .
    METHODS render
      RAISING
        zcx_abapgit_exception .
    METHODS call_page
      IMPORTING
        !ii_page          TYPE REF TO zif_abapgit_gui_renderable
        !iv_with_bookmark TYPE abap_bool DEFAULT abap_false
        !iv_replacing     TYPE abap_bool DEFAULT abap_false
      RAISING
        zcx_abapgit_exception .
    METHODS handle_action
      IMPORTING
        !iv_action   TYPE c
        !iv_getdata  TYPE c OPTIONAL
        !it_postdata TYPE cnht_post_data_tab OPTIONAL .
    METHODS handle_error
      IMPORTING
        !ix_exception TYPE REF TO zcx_abapgit_exception .