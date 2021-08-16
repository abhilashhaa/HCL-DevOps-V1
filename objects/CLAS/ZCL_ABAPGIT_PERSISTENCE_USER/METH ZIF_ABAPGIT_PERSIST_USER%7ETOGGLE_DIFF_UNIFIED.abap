  METHOD zif_abapgit_persist_user~toggle_diff_unified.

    DATA ls_user TYPE ty_user.

    ls_user = read( ).
    ls_user-diff_unified = boolc( ls_user-diff_unified = abap_false ).
    update( ls_user ).

    rv_diff_unified = ls_user-diff_unified.

  ENDMETHOD.