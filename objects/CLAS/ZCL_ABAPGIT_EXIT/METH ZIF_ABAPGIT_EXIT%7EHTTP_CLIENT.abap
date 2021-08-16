  METHOD zif_abapgit_exit~http_client.

    TRY.
        gi_exit->http_client(
          iv_url    = iv_url
          ii_client = ii_client ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.