  METHOD zif_abapgit_environment~is_merged.
    DATA lr_marker TYPE REF TO data ##NEEDED.

    IF mv_is_merged = abap_undefined.
      TRY.
          CREATE DATA lr_marker TYPE REF TO ('LIF_ABAPMERGE_MARKER').
          "No exception --> marker found
          mv_is_merged = abap_true.

        CATCH cx_sy_create_data_error.
          mv_is_merged = abap_false.
      ENDTRY.
    ENDIF.
    rv_result = mv_is_merged.
  ENDMETHOD.