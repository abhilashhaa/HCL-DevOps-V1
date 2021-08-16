  METHOD stage_all.

    FIELD-SYMBOLS <ls_local> LIKE LINE OF ms_files-local.
    FIELD-SYMBOLS <ls_remote> LIKE LINE OF ms_files-remote.
    FIELD-SYMBOLS <ls_status> LIKE LINE OF ms_files-status.

    CREATE OBJECT ro_stage.

    LOOP AT ms_files-local ASSIGNING <ls_local>.
      READ TABLE ms_files-status ASSIGNING <ls_status>
        WITH TABLE KEY
          path     = <ls_local>-file-path
          filename = <ls_local>-file-filename.
      ASSERT sy-subrc = 0.

      ro_stage->add(
        iv_path     = <ls_local>-file-path
        iv_filename = <ls_local>-file-filename
        is_status   = <ls_status>
        iv_data     = <ls_local>-file-data ).
    ENDLOOP.

    LOOP AT ms_files-remote ASSIGNING <ls_remote>.
      READ TABLE ms_files-status ASSIGNING <ls_status>
        WITH TABLE KEY
          path     = <ls_remote>-path
          filename = <ls_remote>-filename.
      ASSERT sy-subrc = 0.

      IF <ls_status>-lstate = zif_abapgit_definitions=>c_state-deleted
        AND <ls_status>-rstate = zif_abapgit_definitions=>c_state-unchanged.

        ro_stage->rm(
          iv_path     = <ls_remote>-path
          iv_filename = <ls_remote>-filename
          is_status   = <ls_status> ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.