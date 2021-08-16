CLASS zcl_abapgit_gui_page_tutorial DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_abapgit_gui_component
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_abapgit_gui_renderable.

    CLASS-METHODS create
      RETURNING
        VALUE(ri_page) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception.
