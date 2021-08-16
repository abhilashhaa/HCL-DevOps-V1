  METHOD CONVERT_FLTP_TO_CURR.

    DATA:
      lr_data TYPE REF TO data,
      lv_curr TYPE bapicurr_d.

    FIELD-SYMBOLS:
      <lv_pack> TYPE any.

    TRY.
        CREATE DATA lr_data TYPE p LENGTH 16 DECIMALS 4.
        ASSIGN lr_data->* TO <lv_pack>.

        <lv_pack> = iv_fltp_value.
        lv_curr = <lv_pack>.
      CATCH cx_sy_conversion_error.
        RAISE conversion_error.
    ENDTRY.

    CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
      EXPORTING
        currency             = iv_currency
        amount_external      = lv_curr
        max_number_of_digits = 23
      IMPORTING
        amount_internal      = rv_curr_value.

  ENDMETHOD.