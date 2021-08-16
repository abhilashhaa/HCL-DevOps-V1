  METHOD zif_abapgit_object~get_metadata.

    CALL METHOD mo_plugin->('ZIF_ABAPGITP_PLUGIN~GET_METADATA')
      RECEIVING
        rs_metadata = rs_metadata.

  ENDMETHOD.