  METHOD refresh.

    DATA:
      lt_diff_files_old TYPE tt_file_diff,
      lt_files          TYPE zif_abapgit_definitions=>ty_stage_tt,
      ls_file           LIKE LINE OF lt_files.

    FIELD-SYMBOLS: <ls_diff_file_old> TYPE zcl_abapgit_gui_page_diff=>ty_file_diff.


    lt_diff_files_old = mt_diff_files.

    CASE iv_action.
      WHEN c_actions-refresh.
        refresh_full( ).
      WHEN c_actions-refresh_local.
        refresh_local( ).
      WHEN OTHERS.
        refresh_local_object( iv_action ).
    ENDCASE.

    " We need to supply files again in calculate_diff. Because
    " we only want to refresh the visible files. Otherwise all
    " diff files would appear.
    " Which is not wanted when we previously only selected particular files.
    LOOP AT lt_diff_files_old ASSIGNING <ls_diff_file_old>.
      CLEAR: ls_file.
      MOVE-CORRESPONDING <ls_diff_file_old> TO ls_file-file.
      INSERT ls_file INTO TABLE lt_files.
    ENDLOOP.

    calculate_diff( it_files = lt_files ).
    restore_patch_flags( lt_diff_files_old ).

  ENDMETHOD.