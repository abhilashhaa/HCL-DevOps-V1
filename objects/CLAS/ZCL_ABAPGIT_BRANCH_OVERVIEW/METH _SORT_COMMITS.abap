  METHOD _sort_commits.

    DATA: lt_sorted_commits TYPE zif_abapgit_definitions=>ty_commit_tt,
          ls_next_commit    TYPE zif_abapgit_definitions=>ty_commit,
          lt_parents        TYPE tyt_commit_sha1_range,
          ls_parent         LIKE LINE OF lt_parents.

    FIELD-SYMBOLS: <ls_initial_commit> TYPE zif_abapgit_definitions=>ty_commit.

* find initial commit
    READ TABLE ct_commits ASSIGNING <ls_initial_commit> WITH KEY parent1 = space.
    IF sy-subrc = 0.

      ls_parent-sign   = 'I'.
      ls_parent-option = 'EQ'.
      ls_parent-low    = <ls_initial_commit>-sha1.
      INSERT ls_parent INTO TABLE lt_parents.

* first commit
      INSERT <ls_initial_commit> INTO TABLE lt_sorted_commits.

* remove from available commits
      DELETE ct_commits WHERE sha1 = <ls_initial_commit>-sha1.

      DO.
        _get_1st_child_commit( EXPORTING it_commit_sha1s = lt_parents
                               IMPORTING et_commit_sha1s = lt_parents
                                         es_1st_commit   = ls_next_commit
                               CHANGING  ct_commits      = ct_commits ).
        IF ls_next_commit IS INITIAL.
          EXIT. "DO
        ENDIF.
        INSERT ls_next_commit INTO TABLE lt_sorted_commits.
      ENDDO.
    ENDIF.

    ct_commits = lt_sorted_commits.

  ENDMETHOD.