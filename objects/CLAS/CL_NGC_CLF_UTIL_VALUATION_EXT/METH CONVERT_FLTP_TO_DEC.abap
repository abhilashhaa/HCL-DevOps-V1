  METHOD CONVERT_FLTP_TO_DEC.

    DATA: lr_data TYPE REF TO data.

    FIELD-SYMBOLS:
      <lv_pack> TYPE any.

    TRY.
        CREATE DATA lr_data TYPE p LENGTH 16 DECIMALS iv_decimals.
        ASSIGN lr_data->* TO <lv_pack>.

        <lv_pack> = iv_fltp_value.
        rv_dec_value = <lv_pack>.

      CATCH cx_sy_conversion_error.
        RAISE conversion_error.
    ENDTRY.

  ENDMETHOD.