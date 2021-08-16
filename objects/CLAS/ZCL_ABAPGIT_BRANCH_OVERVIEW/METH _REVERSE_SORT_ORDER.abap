  METHOD _reverse_sort_order.
    DATA: lt_commits           TYPE zif_abapgit_definitions=>ty_commit_tt.
    FIELD-SYMBOLS: <ls_commit> TYPE zif_abapgit_definitions=>ty_commit.

    LOOP AT ct_commits ASSIGNING <ls_commit>.
      INSERT <ls_commit> INTO lt_commits INDEX 1.
    ENDLOOP.
    ct_commits = lt_commits.
    FREE lt_commits.

  ENDMETHOD.