  METHOD get_persistence.

    CALL METHOD ('CL_UCON_SA_DB_PERSIST')=>('IF_UCON_SA_PERSIST~GET_INSTANCE')
      EXPORTING
        id       = iv_id
      RECEIVING
        instance = ro_persistence.

  ENDMETHOD.