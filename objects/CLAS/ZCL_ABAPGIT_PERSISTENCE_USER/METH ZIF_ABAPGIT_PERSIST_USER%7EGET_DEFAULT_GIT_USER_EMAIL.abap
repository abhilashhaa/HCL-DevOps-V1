  METHOD zif_abapgit_persist_user~get_default_git_user_email.

    rv_email = read( )-default_git_user-email.

  ENDMETHOD.