  PRIVATE SECTION.

    DATA mo_settings TYPE REF TO zcl_abapgit_settings .
    DATA mx_error TYPE REF TO zcx_abapgit_exception .
    DATA mo_exception_viewer TYPE REF TO zcl_abapgit_exception_viewer .

    METHODS render_deferred_parts
      IMPORTING
        !ii_html          TYPE REF TO zif_abapgit_html
        !iv_part_category TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS html_head
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS title
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS footer
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_link_hints
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_command_palettes
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_hotkey_overview
      RETURNING
        VALUE(ro_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_error_message_box
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .