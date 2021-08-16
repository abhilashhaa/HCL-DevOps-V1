CLASS zcl_abapgit_syntax_highlighter DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS create
      IMPORTING
        !iv_filename       TYPE string
      RETURNING
        VALUE(ro_instance) TYPE REF TO zcl_abapgit_syntax_highlighter .
    METHODS process_line
      IMPORTING
        !iv_line       TYPE string
      RETURNING
        VALUE(rv_line) TYPE string .