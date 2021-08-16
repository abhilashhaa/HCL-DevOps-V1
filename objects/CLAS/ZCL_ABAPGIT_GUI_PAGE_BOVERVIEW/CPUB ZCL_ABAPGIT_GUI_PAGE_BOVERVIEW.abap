CLASS zcl_abapgit_gui_page_boverview DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zcl_abapgit_gui_page.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING io_repo TYPE REF TO zcl_abapgit_repo_online
        RAISING   zcx_abapgit_exception,
      zif_abapgit_gui_event_handler~on_event REDEFINITION.
