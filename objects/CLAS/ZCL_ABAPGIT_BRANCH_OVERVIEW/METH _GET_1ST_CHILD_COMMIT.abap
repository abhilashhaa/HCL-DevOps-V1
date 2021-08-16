  METHOD _get_1st_child_commit.

    DATA: lt_1stchild_commits TYPE zif_abapgit_definitions=>ty_commit_tt,
          ls_parent           LIKE LINE OF it_commit_sha1s,
          lt_commit_sha1s     LIKE it_commit_sha1s.

    FIELD-SYMBOLS: <ls_child_commit> TYPE zif_abapgit_definitions=>ty_commit.

    CLEAR: es_1st_commit.

* get all reachable next commits
    lt_commit_sha1s = it_commit_sha1s.
    LOOP AT ct_commits ASSIGNING <ls_child_commit> WHERE parent1 IN lt_commit_sha1s
                                                      OR parent2 IN lt_commit_sha1s.
      INSERT <ls_child_commit> INTO TABLE lt_1stchild_commits.
    ENDLOOP.

* return oldest one
    SORT lt_1stchild_commits BY time ASCENDING.
    READ TABLE lt_1stchild_commits INTO es_1st_commit INDEX 1.

* remove from available commits
    DELETE ct_commits WHERE sha1 = es_1st_commit-sha1.

* set relevant parent commit sha1s
    IF lines( lt_1stchild_commits ) = 1.
      CLEAR et_commit_sha1s.
    ELSE.
      et_commit_sha1s = it_commit_sha1s.
    ENDIF.

    ls_parent-sign   = 'I'.
    ls_parent-option = 'EQ'.
    ls_parent-low    = es_1st_commit-sha1.
    INSERT ls_parent INTO TABLE et_commit_sha1s.

  ENDMETHOD.