  METHOD fixes.

    FIELD-SYMBOLS: <ls_commit> LIKE LINE OF mt_commits.


    LOOP AT mt_commits ASSIGNING <ls_commit> WHERE NOT merge IS INITIAL.
* commits from old branches
      IF <ls_commit>-branch = <ls_commit>-merge.
        CLEAR <ls_commit>-merge.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.