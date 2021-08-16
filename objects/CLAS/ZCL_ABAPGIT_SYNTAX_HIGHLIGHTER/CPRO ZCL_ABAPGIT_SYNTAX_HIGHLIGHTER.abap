  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_match,
        token    TYPE c LENGTH 1,  " Type of matches
        offset   TYPE i,      " Beginning position of the string that should be formatted
        length   TYPE i,      " Length of the string that should be formatted
        text_tag TYPE string, " Type of text tag
      END OF ty_match .
    TYPES:
      ty_match_tt  TYPE STANDARD TABLE OF ty_match WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_rule,
        regex             TYPE REF TO cl_abap_regex,
        token             TYPE c LENGTH 1,
        style             TYPE string,
        relevant_submatch TYPE i,
      END OF ty_rule .

    CONSTANTS c_token_none TYPE c VALUE '.' ##NO_TEXT.
    DATA:
      mt_rules TYPE STANDARD TABLE OF ty_rule .

    METHODS add_rule
      IMPORTING
        !iv_regex    TYPE string
        !iv_token    TYPE c
        !iv_style    TYPE string
        !iv_submatch TYPE i OPTIONAL .
    METHODS parse_line
      IMPORTING
        !iv_line          TYPE string
      RETURNING
        VALUE(rt_matches) TYPE ty_match_tt .
    METHODS order_matches
          ABSTRACT
      IMPORTING
        !iv_line    TYPE string
      CHANGING
        !ct_matches TYPE ty_match_tt .
    METHODS extend_matches
      IMPORTING
        !iv_line    TYPE string
      CHANGING
        !ct_matches TYPE ty_match_tt .
    METHODS format_line
      IMPORTING
        !iv_line       TYPE string
        !it_matches    TYPE ty_match_tt
      RETURNING
        VALUE(rv_line) TYPE string .
    METHODS apply_style
      IMPORTING
        !iv_line       TYPE string
        !iv_class      TYPE string
      RETURNING
        VALUE(rv_line) TYPE string .
    METHODS is_whitespace
      IMPORTING
        !iv_string       TYPE string
      RETURNING
        VALUE(rv_result) TYPE abap_bool .