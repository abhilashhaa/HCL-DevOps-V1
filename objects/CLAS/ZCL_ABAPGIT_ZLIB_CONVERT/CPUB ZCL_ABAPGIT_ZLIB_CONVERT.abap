CLASS zcl_abapgit_zlib_convert DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS hex_to_bits
      IMPORTING
        !iv_hex        TYPE xsequence
      RETURNING
        VALUE(rv_bits) TYPE string .
    CLASS-METHODS bits_to_int
      IMPORTING
        !iv_bits      TYPE clike
      RETURNING
        VALUE(rv_int) TYPE i .
    CLASS-METHODS int_to_hex
      IMPORTING
        !iv_int       TYPE i
      RETURNING
        VALUE(rv_hex) TYPE xstring .