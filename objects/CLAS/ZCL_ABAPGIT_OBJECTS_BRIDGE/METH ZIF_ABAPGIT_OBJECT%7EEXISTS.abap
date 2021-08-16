  METHOD zif_abapgit_object~exists.

    CALL METHOD mo_plugin->('ZIF_ABAPGITP_PLUGIN~EXISTS')
      RECEIVING
        rv_bool = rv_bool.

  ENDMETHOD.