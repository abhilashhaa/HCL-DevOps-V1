CLASS zcl_abapgit_gui_page_addonline DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_component
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    INTERFACES zif_abapgit_gui_event_handler.
    INTERFACES zif_abapgit_gui_renderable.

    CLASS-METHODS create
      " TODO importing prefilled form data
      RETURNING
        VALUE(ri_page) TYPE REF TO zif_abapgit_gui_renderable
      RAISING
        zcx_abapgit_exception.

    METHODS constructor
      RAISING
        zcx_abapgit_exception.
