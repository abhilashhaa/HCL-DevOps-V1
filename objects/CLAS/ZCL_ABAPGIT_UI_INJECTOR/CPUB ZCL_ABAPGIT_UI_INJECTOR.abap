CLASS zcl_abapgit_ui_injector DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS set_popups
      IMPORTING
        !ii_popups TYPE REF TO zif_abapgit_popups .
    CLASS-METHODS set_tag_popups
      IMPORTING
        !ii_tag_popups TYPE REF TO zif_abapgit_tag_popups .
    CLASS-METHODS set_gui_functions
      IMPORTING
        !ii_gui_functions TYPE REF TO zif_abapgit_gui_functions .
    CLASS-METHODS set_gui_services
      IMPORTING
        !ii_gui_services TYPE REF TO zif_abapgit_gui_services .
    CLASS-METHODS get_dummy_gui_services
      RETURNING
        VALUE(ri_gui_services) TYPE REF TO zif_abapgit_gui_services .
    CLASS-METHODS set_html_viewer
      IMPORTING
        !ii_html_viewer TYPE REF TO zif_abapgit_html_viewer .