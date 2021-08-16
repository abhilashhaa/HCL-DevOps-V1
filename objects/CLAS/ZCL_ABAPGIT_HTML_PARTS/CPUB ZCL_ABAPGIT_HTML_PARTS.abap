CLASS zcl_abapgit_html_parts DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS add_part
      IMPORTING
        !iv_collection TYPE string
        !ii_part TYPE REF TO zif_abapgit_html .
    METHODS get_parts
      IMPORTING
        !iv_collection TYPE string
      RETURNING
        VALUE(rt_parts) TYPE zif_abapgit_html=>tty_table_of .
    METHODS get_collection_names
      RETURNING
        VALUE(rt_list) TYPE string_table .
    METHODS get_collection_size
      IMPORTING
        !iv_collection TYPE string
      RETURNING
        VALUE(rv_size) TYPE i .
    METHODS clear.