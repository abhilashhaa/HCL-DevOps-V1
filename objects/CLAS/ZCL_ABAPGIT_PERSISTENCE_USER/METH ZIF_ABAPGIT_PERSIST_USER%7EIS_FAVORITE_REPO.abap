  METHOD zif_abapgit_persist_user~is_favorite_repo.

    DATA: lt_favorites TYPE tt_favorites.

    lt_favorites = zif_abapgit_persist_user~get_favorites( ).

    READ TABLE lt_favorites TRANSPORTING NO FIELDS
      WITH KEY table_line = iv_repo_key.

    rv_yes = boolc( sy-subrc = 0 ).

  ENDMETHOD.