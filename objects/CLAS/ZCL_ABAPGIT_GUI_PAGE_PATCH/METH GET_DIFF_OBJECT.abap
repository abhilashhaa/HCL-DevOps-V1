  METHOD get_diff_object.

    FIELD-SYMBOLS: <ls_diff_file> LIKE LINE OF mt_diff_files.

    LOOP AT mt_diff_files ASSIGNING <ls_diff_file>.
      IF get_normalized_fname_with_path( <ls_diff_file> ) = iv_filename.
        ro_diff = <ls_diff_file>-o_diff.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF ro_diff IS NOT BOUND.
      zcx_abapgit_exception=>raise( |Invalid filename { iv_filename }| ).
    ENDIF.

  ENDMETHOD.