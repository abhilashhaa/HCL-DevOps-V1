  METHOD resolve_diff.

    DATA: lv_offs TYPE i.
    FIELD-SYMBOLS: <ls_conflict> TYPE zif_abapgit_definitions=>ty_merge_conflict.

    CLEAR ms_diff_file.

    READ TABLE mt_conflicts ASSIGNING <ls_conflict> INDEX mv_current_conflict_index.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    ms_diff_file-path     = <ls_conflict>-path.
    ms_diff_file-filename = <ls_conflict>-filename.
    ms_diff_file-type = reverse( <ls_conflict>-filename ).

    FIND FIRST OCCURRENCE OF '.' IN ms_diff_file-type MATCH OFFSET lv_offs.
    ms_diff_file-type = reverse( substring( val = ms_diff_file-type
                                            len = lv_offs ) ).
    IF ms_diff_file-type <> 'xml' AND ms_diff_file-type <> 'abap'.
      ms_diff_file-type = 'other'.
    ENDIF.

    IF ms_diff_file-type = 'other'
    AND is_binary( iv_d1 = <ls_conflict>-source_data
                   iv_d2 = <ls_conflict>-target_data ) = abap_true.
      ms_diff_file-type = 'binary'.
    ENDIF.

    IF ms_diff_file-type <> 'binary'.
      CREATE OBJECT ms_diff_file-o_diff
        EXPORTING
          iv_new = <ls_conflict>-source_data
          iv_old = <ls_conflict>-target_data.
    ENDIF.

  ENDMETHOD.