  METHOD calculate_line_num_and_stats.

    DATA: lv_new TYPE i VALUE 1,
          lv_old TYPE i VALUE 1.

    FIELD-SYMBOLS: <ls_diff> LIKE LINE OF mt_diff.


    LOOP AT mt_diff ASSIGNING <ls_diff>.
      <ls_diff>-new_num = lv_new.
      <ls_diff>-old_num = lv_old.

      CASE <ls_diff>-result. " Line nums
        WHEN zif_abapgit_definitions=>c_diff-delete.
          lv_old = lv_old + 1.
          CLEAR <ls_diff>-new_num.
        WHEN zif_abapgit_definitions=>c_diff-insert.
          lv_new = lv_new + 1.
          CLEAR <ls_diff>-old_num.
        WHEN OTHERS.
          lv_new = lv_new + 1.
          lv_old = lv_old + 1.
      ENDCASE.

      CASE <ls_diff>-result. " Stats
        WHEN zif_abapgit_definitions=>c_diff-insert.
          ms_stats-insert = ms_stats-insert + 1.
        WHEN zif_abapgit_definitions=>c_diff-delete.
          ms_stats-delete = ms_stats-delete + 1.
        WHEN zif_abapgit_definitions=>c_diff-update.
          ms_stats-update = ms_stats-update + 1.
      ENDCASE.

    ENDLOOP.

  ENDMETHOD.