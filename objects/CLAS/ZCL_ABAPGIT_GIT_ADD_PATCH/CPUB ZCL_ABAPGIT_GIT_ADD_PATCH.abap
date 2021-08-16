CLASS zcl_abapgit_git_add_patch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          it_diff TYPE zif_abapgit_definitions=>ty_diffs_tt,

      get_patch
        RETURNING
          VALUE(rt_patch) TYPE string_table
        RAISING
          zcx_abapgit_exception,

      get_patch_binary
        RETURNING
          VALUE(rv_patch_binary) TYPE xstring
        RAISING
          zcx_abapgit_exception.