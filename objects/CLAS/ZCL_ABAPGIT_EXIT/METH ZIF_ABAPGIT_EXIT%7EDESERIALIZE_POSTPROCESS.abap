  METHOD zif_abapgit_exit~deserialize_postprocess.

    TRY.
        gi_exit->deserialize_postprocess( is_step = is_step
                                          ii_log  = ii_log ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.