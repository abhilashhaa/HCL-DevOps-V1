  METHOD get_local_checksums_per_file.

    FIELD-SYMBOLS <ls_object> LIKE LINE OF ms_data-local_checksums.

    LOOP AT ms_data-local_checksums ASSIGNING <ls_object>.
      " Check if item exists
      READ TABLE mt_local TRANSPORTING NO FIELDS
        WITH KEY item = <ls_object>-item.
      IF sy-subrc = 0.
        APPEND LINES OF <ls_object>-files TO rt_checksums.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.