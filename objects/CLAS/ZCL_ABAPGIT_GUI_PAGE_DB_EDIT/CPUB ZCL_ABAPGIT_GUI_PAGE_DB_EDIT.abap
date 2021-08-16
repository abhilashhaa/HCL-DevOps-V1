CLASS zcl_abapgit_gui_page_db_edit DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_page
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        is_key TYPE zif_abapgit_persistence=>ty_content
      RAISING zcx_abapgit_exception.

    METHODS zif_abapgit_gui_event_handler~on_event
        REDEFINITION .