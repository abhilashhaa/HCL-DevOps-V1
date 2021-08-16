  METHOD is_baseinfo_supported.

    DATA:
      lr_data_baseinfo TYPE REF TO data,
      lx_error         TYPE REF TO cx_root.

    TRY.
        CREATE DATA lr_data_baseinfo TYPE ('IF_DD_DDL_TYPES=>TY_S_BASEINFO_STRING_SAVE').
        rv_supported = abap_true.
      CATCH cx_root INTO lx_error.
        rv_supported = abap_false.
    ENDTRY.

  ENDMETHOD.