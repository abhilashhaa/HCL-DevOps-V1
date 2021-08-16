  METHOD count_default_files_to_commit.

    FIELD-SYMBOLS <ls_status> LIKE LINE OF ms_files-status.
    FIELD-SYMBOLS <ls_remote> LIKE LINE OF ms_files-remote.

    rv_count = lines( ms_files-local ).

    LOOP AT ms_files-remote ASSIGNING <ls_remote>.
      READ TABLE ms_files-status ASSIGNING <ls_status>
        WITH TABLE KEY
          path     = <ls_remote>-path
          filename = <ls_remote>-filename.
      ASSERT sy-subrc = 0.

      IF <ls_status>-lstate = zif_abapgit_definitions=>c_state-deleted
        AND <ls_status>-rstate = zif_abapgit_definitions=>c_state-unchanged.
        rv_count = rv_count + 1.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.