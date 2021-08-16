CLASS zcl_abapgit_objects_generic DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !is_item TYPE zif_abapgit_definitions=>ty_item
      RAISING
        zcx_abapgit_exception .
    METHODS delete
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize
      IMPORTING
        !iv_package TYPE devclass
        !io_xml     TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS exists
      RETURNING
        VALUE(rv_bool) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS serialize
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .