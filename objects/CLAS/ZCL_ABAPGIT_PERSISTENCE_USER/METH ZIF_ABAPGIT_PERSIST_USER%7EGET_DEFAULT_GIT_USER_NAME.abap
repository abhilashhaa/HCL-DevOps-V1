  METHOD zif_abapgit_persist_user~get_default_git_user_name.

    rv_username = read( )-default_git_user-name.

  ENDMETHOD.