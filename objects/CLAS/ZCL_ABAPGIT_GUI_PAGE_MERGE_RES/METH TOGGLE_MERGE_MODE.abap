  METHOD toggle_merge_mode.

    IF mv_merge_mode = c_merge_mode-selection.
      mv_merge_mode = c_merge_mode-merge.
    ELSE.
      mv_merge_mode = c_merge_mode-selection.
    ENDIF.

  ENDMETHOD.