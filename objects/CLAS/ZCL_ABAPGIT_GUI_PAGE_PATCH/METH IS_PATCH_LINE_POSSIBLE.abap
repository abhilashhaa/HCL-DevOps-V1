  METHOD is_patch_line_possible.

    IF is_diff_line-result = zif_abapgit_definitions=>c_diff-update
    OR is_diff_line-result = zif_abapgit_definitions=>c_diff-insert
    OR is_diff_line-result = zif_abapgit_definitions=>c_diff-delete.
      rv_is_patch_line_possible = abap_true.
    ENDIF.

  ENDMETHOD.