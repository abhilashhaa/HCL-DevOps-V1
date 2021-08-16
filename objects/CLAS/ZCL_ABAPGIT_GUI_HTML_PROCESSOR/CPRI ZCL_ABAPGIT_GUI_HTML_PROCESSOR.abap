  PRIVATE SECTION.
    DATA mt_preserve_css TYPE string_table.
    DATA mi_asset_man TYPE REF TO zif_abapgit_gui_asset_manager.

    METHODS patch_html
      IMPORTING
        iv_html TYPE string
      EXPORTING
        ev_html TYPE string
        et_css_urls TYPE string_table
      RAISING
        zcx_abapgit_exception.

    METHODS is_preserved
      IMPORTING
        !iv_css_url TYPE string
      RETURNING
        VALUE(rv_yes) TYPE abap_bool.

    METHODS find_head_offset
      IMPORTING
        iv_html            TYPE string
      RETURNING
        VALUE(rv_head_end) TYPE i
      RAISING
        zcx_abapgit_exception.
