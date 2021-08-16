  PRIVATE SECTION.

    CONSTANTS:
      c_pack_start TYPE x LENGTH 4 VALUE '5041434B' ##NO_TEXT.
    CONSTANTS:
      c_zlib       TYPE x LENGTH 2 VALUE '789C' ##NO_TEXT.
    CONSTANTS:
      c_zlib_hmm   TYPE x LENGTH 2 VALUE '7801' ##NO_TEXT.
    CONSTANTS:                                                    " PACK
      c_version    TYPE x LENGTH 4 VALUE '00000002' ##NO_TEXT.

    CLASS-METHODS decode_deltas
      CHANGING
        !ct_objects TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS delta
      IMPORTING
        !is_object  TYPE zif_abapgit_definitions=>ty_object
      CHANGING
        !ct_objects TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS delta_header
      IMPORTING
        !io_stream       TYPE REF TO lcl_stream
      RETURNING
        VALUE(rv_header) TYPE i .
    CLASS-METHODS sort_tree
      IMPORTING
        !it_nodes       TYPE ty_nodes_tt
      RETURNING
        VALUE(rt_nodes) TYPE ty_nodes_tt .
    CLASS-METHODS get_type
      IMPORTING
        !iv_x          TYPE x
      RETURNING
        VALUE(rv_type) TYPE zif_abapgit_definitions=>ty_type
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_length
      EXPORTING
        !ev_length TYPE i
      CHANGING
        !cv_data   TYPE xstring .
    CLASS-METHODS type_and_length
      IMPORTING
        !iv_type          TYPE zif_abapgit_definitions=>ty_type
        !iv_length        TYPE i
      RETURNING
        VALUE(rv_xstring) TYPE xstring
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS zlib_decompress
      CHANGING
        !cv_data         TYPE xstring
        !cv_decompressed TYPE xstring
      RAISING
        zcx_abapgit_exception .