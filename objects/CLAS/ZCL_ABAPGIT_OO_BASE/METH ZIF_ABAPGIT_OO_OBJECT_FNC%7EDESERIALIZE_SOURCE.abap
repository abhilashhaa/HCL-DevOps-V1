  METHOD zif_abapgit_oo_object_fnc~deserialize_source.
    TRY.
        deserialize_abap_source_new(
          is_clskey = is_key
          it_source = it_source ).
      CATCH cx_sy_dyn_call_error.
        deserialize_abap_source_old(
          is_clskey = is_key
          it_source = it_source ).
    ENDTRY.
  ENDMETHOD.