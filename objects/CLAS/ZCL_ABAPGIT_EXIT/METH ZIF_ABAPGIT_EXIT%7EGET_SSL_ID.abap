  METHOD zif_abapgit_exit~get_ssl_id.

    TRY.
        rv_ssl_id = gi_exit->get_ssl_id( ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

    IF rv_ssl_id IS INITIAL.
      rv_ssl_id = 'ANONYM'.
    ENDIF.

  ENDMETHOD.