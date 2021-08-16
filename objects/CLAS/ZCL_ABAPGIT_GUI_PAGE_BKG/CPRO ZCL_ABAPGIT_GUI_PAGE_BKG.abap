  PROTECTED SECTION.

    METHODS read_persist
      IMPORTING
        !io_repo          TYPE REF TO zcl_abapgit_repo_online
      RETURNING
        VALUE(rs_persist) TYPE zcl_abapgit_persist_background=>ty_background
      RAISING
        zcx_abapgit_exception .
    METHODS render_methods
      IMPORTING
        !is_per        TYPE zcl_abapgit_persist_background=>ty_background
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_settings
      IMPORTING
        !is_per        TYPE zcl_abapgit_persist_background=>ty_background
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS build_menu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .
    CLASS-METHODS update
      IMPORTING
        !is_bg_task TYPE zcl_abapgit_persist_background=>ty_background
      RAISING
        zcx_abapgit_exception .
    METHODS render
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS decode
      IMPORTING
        !iv_getdata      TYPE clike
      RETURNING
        VALUE(rs_fields) TYPE zcl_abapgit_persist_background=>ty_background .

    METHODS render_content
        REDEFINITION .