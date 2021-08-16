  METHOD zif_abapgit_exit~allow_sap_objects.

    TRY.
        rv_allowed = gi_exit->allow_sap_objects( ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.