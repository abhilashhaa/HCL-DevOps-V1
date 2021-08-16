CLASS zcl_abapgit_zlib DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_decompress,
        raw            TYPE xstring,
        compressed_len TYPE i,
      END OF ty_decompress .

    CLASS-METHODS decompress
      IMPORTING
        !iv_compressed TYPE xsequence
      RETURNING
        VALUE(rs_data) TYPE ty_decompress .
