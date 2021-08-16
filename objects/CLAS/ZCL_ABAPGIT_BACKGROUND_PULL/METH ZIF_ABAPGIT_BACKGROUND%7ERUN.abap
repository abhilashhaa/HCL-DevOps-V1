  METHOD zif_abapgit_background~run.

    DATA: ls_checks TYPE zif_abapgit_definitions=>ty_deserialize_checks.

    FIELD-SYMBOLS: <ls_overwrite> LIKE LINE OF ls_checks-overwrite.


    ls_checks = io_repo->deserialize_checks( ).

    LOOP AT ls_checks-overwrite ASSIGNING <ls_overwrite>.
      <ls_overwrite>-decision = zif_abapgit_definitions=>gc_yes.
    ENDLOOP.

    io_repo->deserialize( is_checks = ls_checks
                          ii_log    = ii_log ).

  ENDMETHOD.