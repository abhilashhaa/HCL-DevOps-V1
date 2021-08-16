CLASS zcl_abapgit_zlib_huffman DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_lengths TYPE STANDARD TABLE OF i WITH DEFAULT KEY.

    CONSTANTS: c_maxbits TYPE i VALUE 15.

    METHODS:
      constructor
        IMPORTING it_lengths TYPE ty_lengths,
      get_count
        IMPORTING iv_index        TYPE i
        RETURNING VALUE(rv_value) TYPE i,
      get_symbol
        IMPORTING iv_index        TYPE i
        RETURNING VALUE(rv_value) TYPE i.
