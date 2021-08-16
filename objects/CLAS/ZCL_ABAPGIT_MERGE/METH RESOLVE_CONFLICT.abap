  METHOD resolve_conflict.

    FIELD-SYMBOLS: <ls_conflict> TYPE zif_abapgit_definitions=>ty_merge_conflict,
                   <ls_result>   LIKE LINE OF ms_merge-result.

    IF is_conflict-result_sha1 IS NOT INITIAL
        AND is_conflict-result_data IS NOT INITIAL.
      READ TABLE mt_conflicts ASSIGNING <ls_conflict> WITH KEY path = is_conflict-path
                                                               filename = is_conflict-filename.
      IF sy-subrc = 0.
        READ TABLE ms_merge-result ASSIGNING <ls_result> WITH KEY path = is_conflict-path
                                                                  name = is_conflict-filename.
        IF sy-subrc = 0.
          <ls_result>-sha1 = is_conflict-result_sha1.

          ms_merge-stage->add( iv_path     = <ls_conflict>-path
                               iv_filename = <ls_conflict>-filename
                               iv_data     = is_conflict-result_data ).

          DELETE mt_conflicts WHERE path     = is_conflict-path
                                AND filename = is_conflict-filename.
        ENDIF.

        READ TABLE ms_merge-result ASSIGNING <ls_result> WITH KEY sha1 = space.
        IF sy-subrc = 0.
          ms_merge-conflict = |{ <ls_result>-name } merge conflict, changed in source and target branch|.
        ELSE.
          CLEAR ms_merge-conflict.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.