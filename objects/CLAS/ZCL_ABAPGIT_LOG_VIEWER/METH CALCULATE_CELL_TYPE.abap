  METHOD calculate_cell_type.

    FIELD-SYMBOLS: <ls_log> LIKE LINE OF gt_log.
    DATA: ls_cell_type LIKE LINE OF <ls_log>-cell_type.

    LOOP AT gt_log ASSIGNING <ls_log>.

      IF <ls_log>-longtext IS NOT INITIAL.
        ls_cell_type-columnname = `LONGTEXT`.
        ls_cell_type-value      = if_salv_c_cell_type=>hotspot.
        INSERT ls_cell_type INTO TABLE <ls_log>-cell_type.
      ENDIF.

      IF <ls_log>-t100 IS NOT INITIAL.
        ls_cell_type-columnname = `T100`.
        ls_cell_type-value      = if_salv_c_cell_type=>hotspot.
        INSERT ls_cell_type INTO TABLE <ls_log>-cell_type.
      ENDIF.

      IF <ls_log>-source IS NOT INITIAL.
        ls_cell_type-columnname = `SOURCE`.
        ls_cell_type-value      = if_salv_c_cell_type=>hotspot.
        INSERT ls_cell_type INTO TABLE <ls_log>-cell_type.
      ENDIF.

      IF <ls_log>-callstack IS NOT INITIAL.
        ls_cell_type-columnname = `CALLSTACK`.
        ls_cell_type-value      = if_salv_c_cell_type=>hotspot.
        INSERT ls_cell_type INTO TABLE <ls_log>-cell_type.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.