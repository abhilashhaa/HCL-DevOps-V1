CLASS zcl_abapgit_gui DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_gui_services .

    CONSTANTS:
      BEGIN OF c_event_state,
        not_handled         TYPE i VALUE 0,
        re_render           TYPE i VALUE 1,
        new_page            TYPE i VALUE 2,
        go_back             TYPE i VALUE 3,
        no_more_act         TYPE i VALUE 4,
        new_page_w_bookmark TYPE i VALUE 5,
        go_back_to_bookmark TYPE i VALUE 6,
        new_page_replacing  TYPE i VALUE 7,
      END OF c_event_state .
    CONSTANTS:
      BEGIN OF c_action,
        go_home TYPE string VALUE 'go_home',
        go_db   TYPE string VALUE 'go_db',
      END OF c_action .

    METHODS go_home
      RAISING
        zcx_abapgit_exception .
    METHODS go_page
      IMPORTING
        !ii_page        TYPE REF TO zif_abapgit_gui_renderable
        !iv_clear_stack TYPE abap_bool DEFAULT abap_true
      RAISING
        zcx_abapgit_exception .
    METHODS back
      IMPORTING
        !iv_to_bookmark TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rv_exit)  TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS on_event
          FOR EVENT sapevent OF zif_abapgit_html_viewer
      IMPORTING
          !action
          !frame
          !getdata
          !postdata
          !query_table .
    METHODS constructor
      IMPORTING
        !io_component         TYPE REF TO object OPTIONAL
        !ii_asset_man         TYPE REF TO zif_abapgit_gui_asset_manager OPTIONAL
        !ii_hotkey_ctl        TYPE REF TO zif_abapgit_gui_hotkey_ctl OPTIONAL
        !ii_html_processor    TYPE REF TO zif_abapgit_gui_html_processor OPTIONAL
        !iv_rollback_on_error TYPE abap_bool DEFAULT abap_true
      RAISING
        zcx_abapgit_exception .
    METHODS free .