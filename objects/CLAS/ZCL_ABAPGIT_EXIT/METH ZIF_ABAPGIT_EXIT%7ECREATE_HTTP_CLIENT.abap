  METHOD zif_abapgit_exit~create_http_client.

    TRY.
        ri_client = gi_exit->create_http_client( iv_url ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.