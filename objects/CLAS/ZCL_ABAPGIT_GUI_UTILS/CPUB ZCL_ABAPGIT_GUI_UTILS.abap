CLASS zcl_abapgit_gui_utils DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS is_renderable
      IMPORTING
        !io_obj TYPE REF TO object
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
    CLASS-METHODS is_event_handler
      IMPORTING
        !io_obj TYPE REF TO object
      RETURNING
        VALUE(rv_yes) TYPE abap_bool .
