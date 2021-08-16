  METHOD filter_changes.

    FIELD-SYMBOLS: <ls_item> TYPE zif_abapgit_definitions=>ty_repo_item.

    DELETE ct_repo_items WHERE changes = 0.
    LOOP AT ct_repo_items ASSIGNING <ls_item>.
      DELETE <ls_item>-files WHERE is_changed = abap_false.
    ENDLOOP.
  ENDMETHOD.