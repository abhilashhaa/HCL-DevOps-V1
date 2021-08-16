  PRIVATE SECTION.
    CLASS-METHODS:
      remove_ignored
        IMPORTING io_repo  TYPE REF TO zcl_abapgit_repo_online
        CHANGING  cs_files TYPE zif_abapgit_definitions=>ty_stage_files,
      remove_identical
        CHANGING cs_files TYPE zif_abapgit_definitions=>ty_stage_files.
