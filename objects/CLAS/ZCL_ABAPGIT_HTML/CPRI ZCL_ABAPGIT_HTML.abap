  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_indent_context,
        no_indent_jscss TYPE abap_bool,
        within_style    TYPE abap_bool,
        within_js       TYPE abap_bool,
        indent          TYPE i,
        indent_str      TYPE string,
      END OF ty_indent_context .
    TYPES:
      BEGIN OF ty_study_result,
        style_open   TYPE abap_bool,
        style_close  TYPE abap_bool,
        script_open  TYPE abap_bool,
        script_close TYPE abap_bool,
        tag_close    TYPE abap_bool,
        curly_close  TYPE abap_bool,
        openings     TYPE i,
        closings     TYPE i,
        singles      TYPE i,
      END OF ty_study_result .

    CLASS-DATA go_single_tags_re TYPE REF TO cl_abap_regex .
    DATA mt_buffer TYPE string_table .

    METHODS indent_line
      CHANGING
        !cs_context TYPE ty_indent_context
        !cv_line    TYPE string .
    METHODS study_line
      IMPORTING
        !iv_line         TYPE string
        !is_context      TYPE ty_indent_context
      RETURNING
        VALUE(rs_result) TYPE ty_study_result .
    METHODS checkbox
      IMPORTING
        !iv_id         TYPE string
        !iv_checked    TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(rv_html) TYPE string .