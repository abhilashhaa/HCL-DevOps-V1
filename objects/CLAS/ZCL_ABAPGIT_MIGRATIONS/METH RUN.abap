  METHOD run.

    " Migrate STDTEXT to TABLE
    zcl_abapgit_persist_migrate=>run( ).

    " Create ZIF_APACK_MANIFEST interface
    zcl_abapgit_apack_migration=>run( ).

    " local .abapgit.xml state, issue #630
    local_dot_abapgit( ).

  ENDMETHOD.