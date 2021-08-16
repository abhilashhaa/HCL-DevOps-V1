CLASS zcl_abapgit_syntax_json DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_syntax_highlighter
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      " JSON... This was easy :-)
      BEGIN OF c_css,
        keyword TYPE string VALUE 'keyword',                "#EC NOTEXT
        text    TYPE string VALUE 'text',                   "#EC NOTEXT
      END OF c_css .
    CONSTANTS:
      BEGIN OF c_token,
        keyword TYPE c VALUE 'K',                           "#EC NOTEXT
        text    TYPE c VALUE 'T',                           "#EC NOTEXT
      END OF c_token .
    CONSTANTS:
      BEGIN OF c_regex,
        " not much here
        keyword TYPE string VALUE 'true|false|null',        "#EC NOTEXT
        " double quoted strings
        text    TYPE string VALUE '"',                      "#EC NOTEXT
      END OF c_regex .

    METHODS constructor .