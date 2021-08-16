CLASS zcl_abapgit_gui_page_stage DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zcl_abapgit_gui_page.

  PUBLIC SECTION.
    INTERFACES zif_abapgit_gui_hotkeys.

    CONSTANTS: BEGIN OF c_action,
                 stage_all    TYPE string VALUE 'stage_all',
                 stage_commit TYPE string VALUE 'stage_commit',
                 stage_filter TYPE string VALUE 'stage_filter',
               END OF c_action.

    METHODS:
      constructor
        IMPORTING
                  io_repo TYPE REF TO zcl_abapgit_repo_online
                  iv_seed TYPE string OPTIONAL
        RAISING   zcx_abapgit_exception,
      zif_abapgit_gui_event_handler~on_event REDEFINITION.
