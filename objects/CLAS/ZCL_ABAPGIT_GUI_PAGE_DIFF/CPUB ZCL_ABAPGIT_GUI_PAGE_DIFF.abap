CLASS zcl_abapgit_gui_page_diff DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_page
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_file_diff,
        path       TYPE string,
        filename   TYPE string,
        obj_type   TYPE string,
        obj_name   TYPE string,
        lstate     TYPE char1,
        rstate     TYPE char1,
        fstate     TYPE char1, " FILE state - Abstraction for shorter ifs
        o_diff     TYPE REF TO zcl_abapgit_diff,
        changed_by TYPE xubname,
        type       TYPE string,
      END OF ty_file_diff.
    TYPES:
      tt_file_diff TYPE STANDARD TABLE OF ty_file_diff
                        WITH NON-UNIQUE DEFAULT KEY
                        WITH NON-UNIQUE SORTED KEY secondary
                             COMPONENTS path filename.

    CONSTANTS:
      BEGIN OF c_fstate,
        local  TYPE char1 VALUE 'L',
        remote TYPE char1 VALUE 'R',
        both   TYPE char1 VALUE 'B',
      END OF c_fstate.

    METHODS constructor
      IMPORTING
        !iv_key    TYPE zif_abapgit_persistence=>ty_repo-key
        !is_file   TYPE zif_abapgit_definitions=>ty_file OPTIONAL
        !is_object TYPE zif_abapgit_definitions=>ty_item OPTIONAL
        !it_files  TYPE zif_abapgit_definitions=>ty_stage_tt OPTIONAL
      RAISING
        zcx_abapgit_exception.

    METHODS zif_abapgit_gui_event_handler~on_event
        REDEFINITION.