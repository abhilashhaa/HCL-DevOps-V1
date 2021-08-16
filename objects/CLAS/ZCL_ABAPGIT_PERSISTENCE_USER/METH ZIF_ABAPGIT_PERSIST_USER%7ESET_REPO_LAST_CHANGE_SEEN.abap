  METHOD zif_abapgit_persist_user~set_repo_last_change_seen.

    DATA: ls_repo_config TYPE ty_repo_config.

    ls_repo_config                  = read_repo_config( iv_url ).
    ls_repo_config-last_change_seen = iv_version.
    update_repo_config( iv_url = iv_url
                        is_repo_config = ls_repo_config ).

  ENDMETHOD.