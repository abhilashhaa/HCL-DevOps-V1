  METHOD zif_abapgit_exit~change_tadir.

    TRY.
        gi_exit->change_tadir(
          EXPORTING
            iv_package = iv_package
            ii_log     = ii_log
          CHANGING
            ct_tadir   = ct_tadir ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.