CLASS zcl_abapgit_html DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_html .

    CONSTANTS c_indent_size TYPE i VALUE 2 ##NO_TEXT.

    CLASS-METHODS class_constructor .
    CLASS-METHODS icon
      IMPORTING
        !iv_name      TYPE string
        !iv_hint      TYPE string OPTIONAL
        !iv_class     TYPE string OPTIONAL
        !iv_onclick   TYPE string OPTIONAL
      RETURNING
        VALUE(rv_str) TYPE string .