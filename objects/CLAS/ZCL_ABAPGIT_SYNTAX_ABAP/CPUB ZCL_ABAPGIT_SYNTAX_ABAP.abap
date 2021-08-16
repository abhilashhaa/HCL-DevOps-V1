CLASS zcl_abapgit_syntax_abap DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_syntax_highlighter
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS class_constructor.
    METHODS constructor.

    CONSTANTS:
      BEGIN OF c_css,
        keyword TYPE string VALUE 'keyword',                "#EC NOTEXT
        text    TYPE string VALUE 'text',                   "#EC NOTEXT
        comment TYPE string VALUE 'comment',                "#EC NOTEXT
      END OF c_css,

      BEGIN OF c_token,
        keyword TYPE c VALUE 'K',                           "#EC NOTEXT
        text    TYPE c VALUE 'T',                           "#EC NOTEXT
        comment TYPE c VALUE 'C',                           "#EC NOTEXT
      END OF c_token,

      BEGIN OF c_regex,
        comment TYPE string VALUE '##|"|^\*',
        text    TYPE string VALUE '`|''|\||\{|\}',
        keyword TYPE string VALUE '&&|\b[-_a-z0-9]+\b',
      END OF c_regex.
