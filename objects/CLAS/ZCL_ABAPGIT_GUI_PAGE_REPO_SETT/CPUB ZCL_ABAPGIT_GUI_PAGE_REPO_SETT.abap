CLASS zcl_abapgit_gui_page_repo_sett DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_page
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
                !io_repo TYPE REF TO zcl_abapgit_repo
      RAISING   zcx_abapgit_exception.

    METHODS zif_abapgit_gui_event_handler~on_event
        REDEFINITION .