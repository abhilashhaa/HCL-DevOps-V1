  METHOD zif_abapgit_object~delete.
    DATA lx_plugin TYPE REF TO cx_static_check.

    TRY.
        CALL METHOD mo_plugin->('ZIF_ABAPGITP_PLUGIN~DELETE').
      CATCH cx_static_check INTO lx_plugin.
        zcx_abapgit_exception=>raise( lx_plugin->get_text( ) ).
    ENDTRY.

  ENDMETHOD.