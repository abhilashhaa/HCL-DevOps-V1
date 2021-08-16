  METHOD zif_abapgit_persist_user~set_repo_show.

    DATA: ls_user TYPE ty_user.


    ls_user = read( ).
    ls_user-repo_show = iv_key.
    update( ls_user ).

    COMMIT WORK AND WAIT.

  ENDMETHOD.