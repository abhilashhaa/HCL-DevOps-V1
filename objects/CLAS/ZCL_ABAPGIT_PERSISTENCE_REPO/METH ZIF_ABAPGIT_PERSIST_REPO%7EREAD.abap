  METHOD zif_abapgit_persist_repo~read.

    DATA lt_repo TYPE zif_abapgit_persistence=>tt_repo.

    lt_repo = list( ).

    READ TABLE lt_repo INTO rs_repo WITH KEY key = iv_key.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_abapgit_not_found.
    ENDIF.

  ENDMETHOD.