  METHOD zif_abapgit_exit~custom_serialize_abap_clif.
    TRY.
        rt_source = gi_exit->custom_serialize_abap_clif( is_class_key ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.