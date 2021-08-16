  PRIVATE SECTION.

    DATA mo_settings TYPE REF TO zcl_abapgit_settings .
    DATA mv_error TYPE abap_bool .
    DATA mt_post_fields TYPE tihttpnvp .
    DATA mt_proxy_bypass TYPE zif_abapgit_definitions=>ty_range_proxy_bypass_url.
    DATA mt_default_hotkeys TYPE zif_abapgit_gui_hotkeys=>tty_hotkey_with_descr.

    METHODS post_commit_msg .
    METHODS post_development_internals .
    METHODS post_hotkeys .
    METHODS render_proxy
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_development_internals
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_form_begin
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_form_end
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_max_lines
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_icon_scaling
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_ui_theme
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_adt_jump_enabled
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_commit_msg
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS post_proxy .
    METHODS post
      IMPORTING
        !it_post_fields TYPE tihttpnvp .
    METHODS validate_settings .
    METHODS persist_settings
      RAISING
        zcx_abapgit_exception .
    METHODS read_settings .
    METHODS render_section_begin
      IMPORTING
        !iv_header     TYPE csequence
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_section_end
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_start_up
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_link_hints
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_hotkeys
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS is_post_field_checked
      IMPORTING
        iv_name          TYPE string
      RETURNING
        VALUE(rv_return) TYPE abap_bool .

    METHODS render_parallel_proc
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .