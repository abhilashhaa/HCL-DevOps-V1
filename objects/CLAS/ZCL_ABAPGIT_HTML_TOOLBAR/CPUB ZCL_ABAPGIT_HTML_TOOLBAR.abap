CLASS zcl_abapgit_html_toolbar DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_id TYPE string OPTIONAL .
    METHODS add
      IMPORTING
        !iv_txt        TYPE string
        !io_sub        TYPE REF TO zcl_abapgit_html_toolbar OPTIONAL
        !iv_typ        TYPE c DEFAULT zif_abapgit_html=>c_action_type-sapevent
        !iv_act        TYPE string OPTIONAL
        !iv_ico        TYPE string OPTIONAL
        !iv_cur        TYPE abap_bool OPTIONAL
        !iv_opt        TYPE c OPTIONAL
        !iv_chk        TYPE abap_bool DEFAULT abap_undefined
        !iv_aux        TYPE string OPTIONAL
        !iv_id         TYPE string OPTIONAL
        !iv_title      TYPE string OPTIONAL
      RETURNING
        VALUE(ro_self) TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS count
      RETURNING
        VALUE(rv_count) TYPE i .
    METHODS render
      IMPORTING
        !iv_right      TYPE abap_bool OPTIONAL
        !iv_sort       TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_as_droplist
      IMPORTING
        !iv_label      TYPE string
        !iv_right      TYPE abap_bool OPTIONAL
        !iv_sort       TYPE abap_bool OPTIONAL
        !iv_corner     TYPE abap_bool OPTIONAL
        !iv_action     TYPE string OPTIONAL
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .