CLASS zcl_abapgit_syntax_xml DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_syntax_highlighter
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF c_css,
        xml_tag  TYPE string VALUE 'xml_tag',               "#EC NOTEXT
        attr     TYPE string VALUE 'attr',                  "#EC NOTEXT
        attr_val TYPE string VALUE 'attr_val',              "#EC NOTEXT
        comment  TYPE string VALUE 'comment',               "#EC NOTEXT
      END OF c_css .
    CONSTANTS:
      BEGIN OF c_token,
        xml_tag  TYPE c VALUE 'X',                          "#EC NOTEXT
        attr     TYPE c VALUE 'A',                          "#EC NOTEXT
        attr_val TYPE c VALUE 'V',                          "#EC NOTEXT
        comment  TYPE c VALUE 'C',                          "#EC NOTEXT
      END OF c_token .
    CONSTANTS:
      BEGIN OF c_regex,
        "for XML tags, we will use a submatch
        " main pattern includes quoted strings so we can ignore < and > in attr values
        xml_tag  TYPE string VALUE '(?:"[^"]*")|(?:''[^'']*'')|([<>])', "#EC NOTEXT
        attr     TYPE string VALUE '(?:^|\s)[-a-z:_0-9]+\s*(?==)', "#EC NOTEXT
        attr_val TYPE string VALUE '("[^"]*")|(''[^'']*'')', "#EC NOTEXT
        " comments <!-- ... -->
        comment  TYPE string VALUE '[\<]!--.*--[\>]|[\<]!--|--[\>]', "#EC NOTEXT
      END OF c_regex .

    METHODS constructor .