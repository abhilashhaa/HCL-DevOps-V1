  PRIVATE SECTION.
    CONSTANTS: c_maxdcodes TYPE i VALUE 30.

    CLASS-DATA: gv_out      TYPE xstring,
                go_lencode  TYPE REF TO zcl_abapgit_zlib_huffman,
                go_distcode TYPE REF TO zcl_abapgit_zlib_huffman,
                go_stream   TYPE REF TO zcl_abapgit_zlib_stream.

    TYPES: BEGIN OF ty_pair,
             length   TYPE i,
             distance TYPE i,
           END OF ty_pair.

    CLASS-METHODS:
      decode
        IMPORTING io_huffman       TYPE REF TO zcl_abapgit_zlib_huffman
        RETURNING VALUE(rv_symbol) TYPE i,
      map_length
        IMPORTING iv_code          TYPE i
        RETURNING VALUE(rv_length) TYPE i,
      map_distance
        IMPORTING iv_code            TYPE i
        RETURNING VALUE(rv_distance) TYPE i,
      dynamic,
      fixed,
      not_compressed,
      decode_loop,
      read_pair
        IMPORTING iv_length      TYPE i
        RETURNING VALUE(rs_pair) TYPE ty_pair,
      copy_out
        IMPORTING is_pair TYPE ty_pair.
