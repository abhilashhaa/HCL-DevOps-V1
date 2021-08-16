CLASS zcl_abapgit_syntax_js DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_syntax_highlighter
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      " JavaScript
      " 1) General keywords
      " 2) Variable types
      " 3) HTML Tags
      BEGIN OF c_css,
        keyword   TYPE string VALUE 'keyword',              "#EC NOTEXT
        text      TYPE string VALUE 'text',                 "#EC NOTEXT
        comment   TYPE string VALUE 'comment',              "#EC NOTEXT
        variables TYPE string VALUE 'variables',            "#EC NOTEXT
      END OF c_css .
    CONSTANTS:
      BEGIN OF c_token,
        keyword   TYPE c VALUE 'K',                         "#EC NOTEXT
        text      TYPE c VALUE 'T',                         "#EC NOTEXT
        comment   TYPE c VALUE 'C',                         "#EC NOTEXT
        variables TYPE c VALUE 'V',                         "#EC NOTEXT
      END OF c_token .
    CONSTANTS:
      BEGIN OF c_regex,
        " comments /* ... */ or //
        comment TYPE string VALUE '\/\*.*\*\/|\/\*|\*\/|\/\/', "#EC NOTEXT
        " single or double quoted strings
        text    TYPE string VALUE '"|''',                   "#EC NOTEXT
        " in general keywords don't contain numbers (except -ms-scrollbar-3dlight-color)
        keyword TYPE string VALUE '\b[a-z-]+\b',            "#EC NOTEXT
      END OF c_regex .

    CLASS-METHODS class_constructor .
    METHODS constructor .