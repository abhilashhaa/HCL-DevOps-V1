  METHOD zif_abapgit_persist_user~toggle_hide_files.

    DATA ls_user TYPE ty_user.

    ls_user = read( ).
    ls_user-hide_files = boolc( ls_user-hide_files = abap_false ).
    update( ls_user ).

    rv_hide = ls_user-hide_files.

  ENDMETHOD.