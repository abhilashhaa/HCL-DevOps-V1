CLASS zcl_abapgit_gui_page_code_insp DEFINITION PUBLIC FINAL CREATE PUBLIC
    INHERITING FROM zcl_abapgit_gui_page_codi_base.

  PUBLIC SECTION.
    INTERFACES: zif_abapgit_gui_hotkeys.

    METHODS:
      constructor
        IMPORTING
          io_repo  TYPE REF TO zcl_abapgit_repo
          io_stage TYPE REF TO zcl_abapgit_stage OPTIONAL
        RAISING
          zcx_abapgit_exception,

      zif_abapgit_gui_event_handler~on_event
        REDEFINITION,

      zif_abapgit_gui_renderable~render
        REDEFINITION.
