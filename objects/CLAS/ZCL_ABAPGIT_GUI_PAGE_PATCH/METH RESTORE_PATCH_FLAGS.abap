  METHOD restore_patch_flags.

    DATA:
      lt_diff_old TYPE zif_abapgit_definitions=>ty_diffs_tt.

    FIELD-SYMBOLS:
      <ls_diff_file>     TYPE ty_file_diff,
      <ls_diff_file_old> TYPE ty_file_diff,
      <ls_diff_old>      TYPE zif_abapgit_definitions=>ty_diff.

    LOOP AT mt_diff_files ASSIGNING <ls_diff_file>.

      READ TABLE it_diff_files_old ASSIGNING <ls_diff_file_old>
                                   WITH KEY secondary
                                   COMPONENTS path     = <ls_diff_file>-path
                                              filename = <ls_diff_file>-filename.
      IF sy-subrc <> 0.
        CONTINUE. " e.g. new objects
      ENDIF.

      lt_diff_old = <ls_diff_file_old>-o_diff->get( ).

      LOOP AT lt_diff_old ASSIGNING <ls_diff_old>
                          WHERE patch_flag = abap_true.

        <ls_diff_file>-o_diff->set_patch_by_old_diff(
            is_diff_old   = <ls_diff_old>
            iv_patch_flag = abap_true ).

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.