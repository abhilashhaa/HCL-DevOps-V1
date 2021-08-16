  METHOD zif_abapgit_persist_user~toggle_changes_only.

    DATA ls_user TYPE ty_user.

    ls_user = read( ).
    ls_user-changes_only = boolc( ls_user-changes_only = abap_false ).
    update( ls_user ).

    rv_changes_only = ls_user-changes_only.

  ENDMETHOD.