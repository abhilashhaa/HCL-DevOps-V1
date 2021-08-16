CLASS zcl_abapgit_xml_input DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_xml
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_xml_input.

    METHODS constructor
      IMPORTING
        !iv_xml      TYPE clike
        !iv_filename TYPE string OPTIONAL
      RAISING
        zcx_abapgit_exception .
