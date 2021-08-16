  METHOD zif_abapgit_persist_user~toggle_favorite.

    DATA: ls_user TYPE ty_user.

    ls_user = read( ).

    READ TABLE ls_user-favorites TRANSPORTING NO FIELDS
      WITH KEY table_line = iv_repo_key.

    IF sy-subrc = 0.
      DELETE ls_user-favorites INDEX sy-tabix.
    ELSE.
      APPEND iv_repo_key TO ls_user-favorites.
    ENDIF.

    update( ls_user ).

    COMMIT WORK AND WAIT.

  ENDMETHOD.