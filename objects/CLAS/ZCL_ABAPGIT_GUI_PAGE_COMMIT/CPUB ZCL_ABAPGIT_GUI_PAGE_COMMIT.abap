CLASS zcl_abapgit_gui_page_commit DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_page
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF c_action,
        commit_post   TYPE string VALUE 'commit_post',
        commit_cancel TYPE string VALUE 'commit_cancel',
      END OF c_action .

    METHODS constructor
      IMPORTING
        io_repo  TYPE REF TO zcl_abapgit_repo_online
        io_stage TYPE REF TO zcl_abapgit_stage
      RAISING
        zcx_abapgit_exception.

    METHODS zif_abapgit_gui_event_handler~on_event
        REDEFINITION .