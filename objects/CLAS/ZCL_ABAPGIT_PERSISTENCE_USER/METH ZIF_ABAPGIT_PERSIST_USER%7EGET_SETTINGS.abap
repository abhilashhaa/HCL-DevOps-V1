  METHOD zif_abapgit_persist_user~get_settings.

    DATA: ls_user TYPE ty_user.

    ls_user = read( ).

    rs_user_settings = ls_user-settings.

  ENDMETHOD.