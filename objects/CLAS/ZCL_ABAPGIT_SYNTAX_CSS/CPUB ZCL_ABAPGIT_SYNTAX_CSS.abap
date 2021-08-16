CLASS zcl_abapgit_syntax_css DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_syntax_highlighter
  CREATE PUBLIC .

  PUBLIC SECTION.

    " CSS Standard            https://www.w3.org/TR/css-2018/
    " CSS Reference           https://www.w3schools.com/cssref/default.asp

    " We used a mixture of above as reference for the keyword list
    " 1) CSS Properties       https://www.w3schools.com/cssref/default.asp
    " 2) CSS Values & Units   https://www.w3schools.com/cssref/css_units.asp
    " 3) CSS Selectors        https://www.w3.org/TR/css-2018/#selectors
    " 4) CSS Functions        https://www.w3schools.com/cssref/css_functions.asp
    " 5) CSS Colors           https://www.w3schools.com/colors/colors_names.asp
    " 6) CSS Extensions
    " 7) CSS At-Rules         https://www.w3.org/TR/css-2018/#at-rules
    " 8) HTML Tags

    CONSTANTS:
      BEGIN OF c_css,
        keyword    TYPE string VALUE 'keyword',             "#EC NOTEXT
        text       TYPE string VALUE 'text',                "#EC NOTEXT
        comment    TYPE string VALUE 'comment',             "#EC NOTEXT
        selectors  TYPE string VALUE 'selectors',           "#EC NOTEXT
        units      TYPE string VALUE 'units',               "#EC NOTEXT
        properties TYPE string VALUE 'properties',          "#EC NOTEXT
        values     TYPE string VALUE 'values',              "#EC NOTEXT
        functions  TYPE string VALUE 'functions',           "#EC NOTEXT
        colors     TYPE string VALUE 'colors',              "#EC NOTEXT
        extensions TYPE string VALUE 'extensions',          "#EC NOTEXT
        at_rules   TYPE string VALUE 'at_rules',            "#EC NOTEXT
        html       TYPE string VALUE 'html',                "#EC NOTEXT
      END OF c_css .
    CONSTANTS:
      BEGIN OF c_token,
        keyword    TYPE c VALUE 'K',                        "#EC NOTEXT
        text       TYPE c VALUE 'T',                        "#EC NOTEXT
        comment    TYPE c VALUE 'C',                        "#EC NOTEXT
        selectors  TYPE c VALUE 'S',                        "#EC NOTEXT
        units      TYPE c VALUE 'U',                        "#EC NOTEXT
        properties TYPE c VALUE 'P',                        "#EC NOTEXT
        values     TYPE c VALUE 'V',                        "#EC NOTEXT
        functions  TYPE c VALUE 'F',                        "#EC NOTEXT
        colors     TYPE c VALUE 'Z',                        "#EC NOTEXT
        extensions TYPE c VALUE 'E',                        "#EC NOTEXT
        at_rules   TYPE c VALUE 'A',                        "#EC NOTEXT
        html       TYPE c VALUE 'H',                        "#EC NOTEXT
      END OF c_token .
    CONSTANTS:
      BEGIN OF c_regex,
        " comments /* ... */
        comment   TYPE string VALUE '\/\*.*\*\/|\/\*|\*\/', "#EC NOTEXT
        " single or double quoted strings
        text      TYPE string VALUE '("[^"]*")|(''[^'']*'')', "#EC NOTEXT
        " in general keywords don't contain numbers (except -ms-scrollbar-3dlight-color)
        keyword   TYPE string VALUE '\b[a-z3@\-]+\b',       "#EC NOTEXT
        " selectors begin with :
        selectors TYPE string VALUE ':[:a-z]+\b',           "#EC NOTEXT
        " units
        units     TYPE string
        VALUE '\b[0-9\. ]+(ch|cm|em|ex|in|mm|pc|pt|px|vh|vmax|vmin|vw)\b|\b[0-9\. ]+%', "#EC NOTEXT
      END OF c_regex .

    CLASS-METHODS class_constructor .
    METHODS constructor .