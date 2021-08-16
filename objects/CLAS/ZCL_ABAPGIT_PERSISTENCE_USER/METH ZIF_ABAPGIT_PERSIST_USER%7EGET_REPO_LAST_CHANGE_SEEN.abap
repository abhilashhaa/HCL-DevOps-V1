  METHOD zif_abapgit_persist_user~get_repo_last_change_seen.

    rv_version = read_repo_config( iv_url )-last_change_seen.

  ENDMETHOD.