  METHOD zif_abapgit_persist_user~set_settings.

    DATA: ls_user TYPE ty_user.

    ls_user = read( ).
    ls_user-settings = is_user_settings.
    update( ls_user ).

  ENDMETHOD.