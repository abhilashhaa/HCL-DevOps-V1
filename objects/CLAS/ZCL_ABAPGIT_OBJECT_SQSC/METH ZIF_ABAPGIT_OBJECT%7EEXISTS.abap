  METHOD zif_abapgit_object~exists.

    CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~EXISTS')
      RECEIVING
        ef_exists = rv_bool.

  ENDMETHOD.