  METHOD find_remote_dot_abapgit.

    FIELD-SYMBOLS: <ls_remote> LIKE LINE OF mt_remote.

    get_files_remote( ).

    READ TABLE mt_remote ASSIGNING <ls_remote>
      WITH KEY path = zif_abapgit_definitions=>c_root_dir
      filename = zif_abapgit_definitions=>c_dot_abapgit.
    IF sy-subrc = 0.
      ro_dot = zcl_abapgit_dot_abapgit=>deserialize( <ls_remote>-data ).
      set_dot_abapgit( ro_dot ).
      COMMIT WORK AND WAIT. " to release lock
    ELSEIF lines( mt_remote ) > c_new_repo_size.
      " Less files means it's a new repo (with just readme and license, for example) which is ok
      zcx_abapgit_exception=>raise( |Cannot find .abapgit.xml - Is this an abapGit repo?| ).
    ENDIF.

  ENDMETHOD.