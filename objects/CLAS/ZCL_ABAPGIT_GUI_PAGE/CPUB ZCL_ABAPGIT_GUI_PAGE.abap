CLASS zcl_abapgit_gui_page DEFINITION PUBLIC ABSTRACT
  INHERITING FROM zcl_abapgit_gui_component
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_gui_renderable,
      zif_abapgit_gui_event_handler,
      zif_abapgit_gui_error_handler.

    METHODS:
      constructor RAISING zcx_abapgit_exception.
