  PRIVATE SECTION.
    DATA:
      mt_diff  TYPE zif_abapgit_definitions=>ty_diffs_tt,
      mt_patch TYPE string_table.

    METHODS:
      calculate_patch
        RETURNING
          VALUE(rt_patch) TYPE string_table
        RAISING
          zcx_abapgit_exception.