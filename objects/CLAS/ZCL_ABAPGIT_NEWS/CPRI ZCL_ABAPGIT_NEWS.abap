  PRIVATE SECTION.

    DATA mt_log TYPE tt_log .
    DATA mv_current_version TYPE string .
    DATA mv_lastseen_version TYPE string .
    DATA mv_latest_version TYPE string .

    METHODS latest_version
      RETURNING
        VALUE(rv_version) TYPE string .
    CLASS-METHODS version_to_numeric
      IMPORTING
        !iv_version       TYPE string
      RETURNING
        VALUE(rv_version) TYPE i .
    CLASS-METHODS normalize_version
      IMPORTING
        !iv_version       TYPE string
      RETURNING
        VALUE(rv_version) TYPE string .
    CLASS-METHODS compare_versions
      IMPORTING
        !iv_a            TYPE string
        !iv_b            TYPE string
      RETURNING
        VALUE(rv_result) TYPE i .
    CLASS-METHODS parse_line
      IMPORTING
        !iv_line            TYPE string
        !iv_current_version TYPE string
      RETURNING
        VALUE(rs_log)       TYPE ty_log .
    CLASS-METHODS parse
      IMPORTING
        !it_lines           TYPE string_table
        !iv_current_version TYPE string
      RETURNING
        VALUE(rt_log)       TYPE tt_log .