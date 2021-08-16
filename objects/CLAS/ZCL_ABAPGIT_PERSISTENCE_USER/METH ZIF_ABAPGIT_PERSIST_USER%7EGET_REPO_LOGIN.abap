  METHOD zif_abapgit_persist_user~get_repo_login.

    rv_login = read_repo_config( iv_url )-login.

  ENDMETHOD.