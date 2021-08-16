  METHOD zif_abapgit_exit~change_local_host.

    TRY.
        gi_exit->change_local_host( CHANGING ct_hosts = ct_hosts ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.