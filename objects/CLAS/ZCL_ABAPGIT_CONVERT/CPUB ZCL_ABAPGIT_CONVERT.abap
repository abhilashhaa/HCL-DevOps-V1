CLASS zcl_abapgit_convert DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS bitbyte_to_int
      IMPORTING
        !iv_bits      TYPE clike
      RETURNING
        VALUE(rv_int) TYPE i .
    CLASS-METHODS x_to_bitbyte
      IMPORTING
        !iv_x             TYPE x
      RETURNING
        VALUE(rv_bitbyte) TYPE zif_abapgit_definitions=>ty_bitbyte .
    CLASS-METHODS string_to_xstring_utf8
      IMPORTING
        !iv_string        TYPE string
      RETURNING
        VALUE(rv_xstring) TYPE xstring .
    CLASS-METHODS xstring_to_string_utf8
      IMPORTING
        !iv_data         TYPE xsequence
      RETURNING
        VALUE(rv_string) TYPE string .
    CLASS-METHODS string_to_xstring_utf8_bom
      IMPORTING
        !iv_string        TYPE string
      RETURNING
        VALUE(rv_xstring) TYPE xstring .
    CLASS-METHODS xstring_to_int
      IMPORTING
        !iv_xstring TYPE xstring
      RETURNING
        VALUE(rv_i) TYPE i
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS int_to_xstring4
      IMPORTING
        !iv_i             TYPE i
      RETURNING
        VALUE(rv_xstring) TYPE xstring .
    CLASS-METHODS split_string
      IMPORTING
        !iv_string      TYPE string
      RETURNING
        VALUE(rt_lines) TYPE string_table .
    CLASS-METHODS conversion_exit_isola_output
      IMPORTING
        !iv_spras       TYPE spras
      RETURNING
        VALUE(rv_spras) TYPE laiso .
    CLASS-METHODS alpha_output
      IMPORTING
        !iv_val       TYPE clike
      RETURNING
        VALUE(rv_str) TYPE string .
    CLASS-METHODS string_to_xstring
      IMPORTING
        !iv_str        TYPE string
      RETURNING
        VALUE(rv_xstr) TYPE xstring .
    CLASS-METHODS string_to_tab
      IMPORTING
        !iv_str  TYPE string
      EXPORTING
        !ev_size TYPE i
        !et_tab  TYPE STANDARD TABLE .
    CLASS-METHODS base64_to_xstring
      IMPORTING
        !iv_base64     TYPE string
      RETURNING
        VALUE(rv_xstr) TYPE xstring .
    CLASS-METHODS bintab_to_xstring
      IMPORTING
        !it_bintab     TYPE lvc_t_mime
        !iv_size       TYPE i
      RETURNING
        VALUE(rv_xstr) TYPE xstring .
    CLASS-METHODS xstring_to_bintab
      IMPORTING
        !iv_xstr   TYPE xstring
      EXPORTING
        !ev_size   TYPE i
        !et_bintab TYPE lvc_t_mime .