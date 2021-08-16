  METHOD read_file.

    FIELD-SYMBOLS: <ls_file>     LIKE LINE OF mt_files,
                   <ls_accessed> LIKE LINE OF mt_accessed_files.


    IF mv_path IS NOT INITIAL.
      READ TABLE mt_files ASSIGNING <ls_file> WITH KEY path     = mv_path
                                                       filename = iv_filename.
    ELSE.
      READ TABLE mt_files ASSIGNING <ls_file> WITH KEY filename = iv_filename.
    ENDIF.

    IF sy-subrc <> 0.
      IF iv_error = abap_true.
        zcx_abapgit_exception=>raise( |File not found: { iv_filename }| ).
      ELSE.
        RETURN.
      ENDIF.
    ENDIF.

    " Update access table
    READ TABLE mt_accessed_files TRANSPORTING NO FIELDS
      WITH KEY path = <ls_file>-path filename = <ls_file>-filename.
    IF sy-subrc > 0. " Not found ? -> Add
      APPEND INITIAL LINE TO mt_accessed_files ASSIGNING <ls_accessed>.
      MOVE-CORRESPONDING <ls_file> TO <ls_accessed>.
    ENDIF.

    rv_data = <ls_file>-data.

  ENDMETHOD.