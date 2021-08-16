  METHOD zif_abapgit_persist_user~set_default_git_user_email.

    DATA: ls_user TYPE ty_user.


    ls_user = read( ).
    ls_user-default_git_user-email = iv_email.
    update( ls_user ).

  ENDMETHOD.