  METHOD is_every_changed_line_patched.

    DATA: lt_diff TYPE zif_abapgit_definitions=>ty_diffs_tt.

    FIELD-SYMBOLS:
      <ls_diff_file> TYPE zcl_abapgit_gui_page_diff=>ty_file_diff,
      <ls_diff>      TYPE zif_abapgit_definitions=>ty_diff.

    rv_everything_patched = abap_true.

    LOOP AT mt_diff_files ASSIGNING <ls_diff_file>.

      lt_diff = <ls_diff_file>-o_diff->get( ).

      LOOP AT lt_diff ASSIGNING <ls_diff>
                      WHERE result IS NOT INITIAL
                      AND   patch_flag = abap_false.
        rv_everything_patched = abap_false.
        EXIT.
      ENDLOOP.
      IF sy-subrc = 0.
        EXIT.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.