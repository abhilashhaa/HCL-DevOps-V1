CLASS zcl_abapgit_gui_page_bkg DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_page
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
                iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING   zcx_abapgit_exception.

    METHODS zif_abapgit_gui_event_handler~on_event
        REDEFINITION .