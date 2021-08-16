CLASS zcl_abapgit_gui_page_hoc DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_abapgit_gui_page
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS create
      IMPORTING
        ii_child_component TYPE REF TO zif_abapgit_gui_renderable
        iv_page_title TYPE string
        io_page_menu TYPE REF TO zcl_abapgit_html_toolbar OPTIONAL
      RETURNING
        VALUE(ri_page_wrap) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception.
