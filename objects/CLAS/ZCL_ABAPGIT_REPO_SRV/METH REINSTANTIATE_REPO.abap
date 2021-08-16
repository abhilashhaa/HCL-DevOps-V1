  METHOD reinstantiate_repo.

    DATA lo_repo      TYPE REF TO zcl_abapgit_repo.
    DATA ls_full_meta TYPE zif_abapgit_persistence=>ty_repo.

    lo_repo = get( iv_key ).
    DELETE TABLE mt_list FROM lo_repo.
    ASSERT sy-subrc IS INITIAL.

    MOVE-CORRESPONDING is_meta TO ls_full_meta.
    ls_full_meta-key = iv_key.

    instantiate_and_add( ls_full_meta ).

  ENDMETHOD.