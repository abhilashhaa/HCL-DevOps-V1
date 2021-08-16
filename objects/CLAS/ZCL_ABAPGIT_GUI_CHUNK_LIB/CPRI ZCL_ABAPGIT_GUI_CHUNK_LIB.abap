  PRIVATE SECTION.

    CLASS-DATA gv_time_zone TYPE timezone .

    CLASS-METHODS render_branch_span
      IMPORTING
        !iv_branch      TYPE string
        !io_repo        TYPE REF TO zcl_abapgit_repo_online
        !iv_interactive TYPE abap_bool
      RETURNING
        VALUE(ri_html)  TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_t100_text
      IMPORTING
        !iv_msgid      TYPE scx_t100key-msgid
        !iv_msgno      TYPE scx_t100key-msgno
      RETURNING
        VALUE(rv_text) TYPE string .
    CLASS-METHODS normalize_program_name
      IMPORTING
        !iv_program_name                  TYPE sy-repid
      RETURNING
        VALUE(rv_normalized_program_name) TYPE string .