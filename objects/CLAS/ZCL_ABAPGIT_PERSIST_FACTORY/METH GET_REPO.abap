  METHOD get_repo.

    IF gi_repo IS INITIAL.
      CREATE OBJECT gi_repo TYPE zcl_abapgit_persistence_repo.
    ENDIF.

    ri_repo = gi_repo.

  ENDMETHOD.