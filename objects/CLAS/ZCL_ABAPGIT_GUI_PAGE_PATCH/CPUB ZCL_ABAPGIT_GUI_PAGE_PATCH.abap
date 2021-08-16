CLASS zcl_abapgit_gui_page_patch DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_page_diff
  CREATE PUBLIC .


  PUBLIC SECTION.
    INTERFACES zif_abapgit_gui_hotkeys.

    METHODS:
      constructor
        IMPORTING
          iv_key        TYPE zif_abapgit_persistence=>ty_repo-key
          is_file       TYPE zif_abapgit_definitions=>ty_file OPTIONAL
          is_object     TYPE zif_abapgit_definitions=>ty_item OPTIONAL
          it_files      TYPE zif_abapgit_definitions=>ty_stage_tt OPTIONAL
          iv_patch_mode TYPE abap_bool OPTIONAL
        RAISING
          zcx_abapgit_exception,

      zif_abapgit_gui_event_handler~on_event REDEFINITION.

    CLASS-METHODS:
      get_patch_data
        IMPORTING
          iv_patch      TYPE string
        EXPORTING
          ev_filename   TYPE string
          ev_line_index TYPE string
        RAISING
          zcx_abapgit_exception.
