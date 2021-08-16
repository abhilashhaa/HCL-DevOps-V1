  METHOD filter_diff_by_files.

    FIELD-SYMBOLS: <ls_diff_file> TYPE ty_file_diff.

    IF lines( it_files ) = 0.
      RETURN.
    ENDIF.

    " Diff only for specified files
    LOOP AT ct_diff_files ASSIGNING <ls_diff_file>.

      READ TABLE it_files TRANSPORTING NO FIELDS
                          WITH KEY file-filename = <ls_diff_file>-filename.
      IF sy-subrc <> 0.
        DELETE TABLE ct_diff_files FROM <ls_diff_file>.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.