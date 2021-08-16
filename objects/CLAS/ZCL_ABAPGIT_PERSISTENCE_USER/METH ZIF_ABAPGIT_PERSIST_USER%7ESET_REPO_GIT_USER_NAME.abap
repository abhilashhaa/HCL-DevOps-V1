  METHOD zif_abapgit_persist_user~set_repo_git_user_name.

    DATA: ls_repo_config TYPE ty_repo_config.

    ls_repo_config               = read_repo_config( iv_url ).
    ls_repo_config-git_user-name = iv_username.
    update_repo_config( iv_url = iv_url
                        is_repo_config = ls_repo_config ).

  ENDMETHOD.