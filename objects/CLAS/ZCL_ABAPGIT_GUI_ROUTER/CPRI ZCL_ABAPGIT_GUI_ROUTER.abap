  PRIVATE SECTION.

    METHODS general_page_routing
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS abapgit_services_actions
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS db_actions
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS file_download
      IMPORTING
        !iv_package TYPE devclass
        !iv_xstr    TYPE xstring
      RAISING
        zcx_abapgit_exception .
    METHODS git_services
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS remote_origin_manipulations
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS sap_gui_actions
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS other_utilities
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS zip_services
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS repository_services
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(rs_handled) TYPE zif_abapgit_gui_event_handler=>ty_handling_result
      RAISING
        zcx_abapgit_exception.
    METHODS get_page_diff
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(ri_page) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception .
    METHODS get_page_branch_overview
      IMPORTING
        !iv_key    TYPE zif_abapgit_persistence=>ty_repo-key
      RETURNING
        VALUE(ri_page) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception .
    METHODS get_page_stage
      IMPORTING
        !ii_event TYPE REF TO zif_abapgit_gui_event
      RETURNING
        VALUE(ri_page) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception .
    METHODS get_page_background
      IMPORTING
        !iv_key        TYPE zif_abapgit_persistence=>ty_repo-key
      RETURNING
        VALUE(ri_page) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception .

    CLASS-METHODS jump_display_transport
      IMPORTING
        !iv_transport TYPE trkorr
      RAISING
        zcx_abapgit_exception.

    METHODS call_browser
      IMPORTING
        iv_url TYPE csequence
      RAISING
        zcx_abapgit_exception.
