  METHOD zif_abapgit_persist_user~get_repo_show.

    DATA lo_repo TYPE REF TO zcl_abapgit_repo.

    rv_key = read( )-repo_show.

    " Check if repo exists
    TRY.
        lo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( rv_key ).
      CATCH zcx_abapgit_exception.
        " remove invalid key
        CLEAR rv_key.
        zif_abapgit_persist_user~set_repo_show( rv_key ).
    ENDTRY.

  ENDMETHOD.