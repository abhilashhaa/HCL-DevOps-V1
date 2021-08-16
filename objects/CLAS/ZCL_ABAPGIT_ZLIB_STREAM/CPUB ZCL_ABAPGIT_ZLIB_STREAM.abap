CLASS zcl_abapgit_zlib_stream DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_data TYPE xstring .
    METHODS take_bits
      IMPORTING
        !iv_length     TYPE i
      RETURNING
        VALUE(rv_bits) TYPE string .
    METHODS take_int
      IMPORTING
        !iv_length    TYPE i
      RETURNING
        VALUE(rv_int) TYPE i .
    METHODS remaining
      RETURNING
        VALUE(rv_length) TYPE i .
    "! Take bytes, there's an implicit realignment to start at the beginning of a byte
    "! i.e. if next bit of current byte is not the first bit, then this byte is skipped
    "! and the bytes are taken from the next one.
    "! @parameter iv_length | <p class="shorttext synchronized" lang="en">Number of BYTES to read (not bits)</p>
    "! @parameter rv_bytes | <p class="shorttext synchronized" lang="en">Bytes taken</p>
    METHODS take_bytes
      IMPORTING
        iv_length       TYPE i
      RETURNING
        VALUE(rv_bytes) TYPE xstring.