  METHOD run.

    DATA: lo_apack_migration TYPE REF TO zcl_abapgit_apack_migration.

    CREATE OBJECT lo_apack_migration.
    lo_apack_migration->perform_migration( ).

  ENDMETHOD.