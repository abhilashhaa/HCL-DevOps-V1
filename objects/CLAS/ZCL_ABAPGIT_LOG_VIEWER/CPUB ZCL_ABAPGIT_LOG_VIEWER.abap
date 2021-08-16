CLASS zcl_abapgit_log_viewer DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS show_log
      IMPORTING
        !iv_header_text TYPE csequence DEFAULT 'Log'
        !ii_log         TYPE REF TO zif_abapgit_log .
    CLASS-METHODS to_html
      IMPORTING
        !ii_log        TYPE REF TO zif_abapgit_log
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    CLASS-METHODS write_log
      IMPORTING
        !ii_log TYPE REF TO zif_abapgit_log .