CLASS zcl_abapgit_transport DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS zip
      IMPORTING
        !iv_show_log_popup TYPE abap_bool DEFAULT abap_true
        !iv_logic          TYPE string OPTIONAL
        !is_trkorr         TYPE trwbo_request_header OPTIONAL
      RETURNING
        VALUE(rv_xstr)     TYPE xstring
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS to_tadir
      IMPORTING
        it_transport_headers TYPE trwbo_request_headers
      RETURNING
        VALUE(rt_tadir)      TYPE zif_abapgit_definitions=>ty_tadir_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS add_all_objects_to_trans_req
      IMPORTING
        iv_key TYPE zif_abapgit_persistence=>ty_value
      RAISING
        zcx_abapgit_exception .