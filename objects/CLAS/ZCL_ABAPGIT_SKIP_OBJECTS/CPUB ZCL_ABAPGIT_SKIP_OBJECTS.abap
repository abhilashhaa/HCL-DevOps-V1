CLASS zcl_abapgit_skip_objects DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      skip_sadl_generated_objects
        IMPORTING
          it_tadir        TYPE zif_abapgit_definitions=>ty_tadir_tt
          ii_log          TYPE REF TO zif_abapgit_log OPTIONAL
        RETURNING
          VALUE(rt_tadir) TYPE zif_abapgit_definitions=>ty_tadir_tt.