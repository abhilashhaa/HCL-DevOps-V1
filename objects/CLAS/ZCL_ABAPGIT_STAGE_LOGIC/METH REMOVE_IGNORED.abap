  METHOD remove_ignored.

    DATA: lv_index TYPE i.

    FIELD-SYMBOLS: <ls_remote> LIKE LINE OF cs_files-remote,
                   <ls_local>  LIKE LINE OF cs_files-local.


    LOOP AT cs_files-remote ASSIGNING <ls_remote>.
      lv_index = sy-tabix.

      IF io_repo->get_dot_abapgit( )->is_ignored(
          iv_path     = <ls_remote>-path
          iv_filename = <ls_remote>-filename ) = abap_true.
        DELETE cs_files-remote INDEX lv_index.
      ELSEIF <ls_remote>-path = zif_abapgit_definitions=>c_root_dir
          AND <ls_remote>-filename = zif_abapgit_definitions=>c_dot_abapgit.
        " Remove .abapgit from remotes - it cannot be removed or ignored
        DELETE cs_files-remote INDEX lv_index.
      ENDIF.

    ENDLOOP.

    LOOP AT cs_files-local ASSIGNING <ls_local>.
      lv_index = sy-tabix.

      IF io_repo->get_dot_abapgit( )->is_ignored(
          iv_path     = <ls_local>-file-path
          iv_filename = <ls_local>-file-filename ) = abap_true.
        DELETE cs_files-local INDEX lv_index.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.