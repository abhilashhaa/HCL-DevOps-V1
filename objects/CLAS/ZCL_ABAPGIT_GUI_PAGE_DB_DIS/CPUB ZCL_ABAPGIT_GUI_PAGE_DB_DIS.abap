CLASS zcl_abapgit_gui_page_db_dis DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zcl_abapgit_gui_page.

  PUBLIC SECTION.

    METHODS: constructor
      IMPORTING is_key TYPE zif_abapgit_persistence=>ty_content
      RAISING zcx_abapgit_exception.

    CLASS-METHODS: render_record_banner
      IMPORTING is_key         TYPE zif_abapgit_persistence=>ty_content
      RETURNING VALUE(rv_html) TYPE string.
