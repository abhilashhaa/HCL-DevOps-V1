  METHOD check_length.

    DATA:
      lv_value_str      TYPE c LENGTH 20,
      lv_value_str_fltp TYPE c LENGTH 20,
      lr_data           TYPE REF TO data,
      lv_decimal_sign   TYPE sy-batch,
      lv_separator      TYPE sy-batch,
      lv_decimals_count TYPE i,
      lv_digits_count   TYPE i.

    FIELD-SYMBOLS: <lv_data> TYPE any.


    CLEAR: et_message.


    " Do not check in case of exponential format
    IF is_charc_header-charcexponentformat CA '123'.
      RETURN.
    ENDIF.

    me->get_user_data(
      IMPORTING
        ev_decimal_sign = lv_decimal_sign
        ev_separator    = lv_separator ).

    " Select decimal places and length based on float representation
    WRITE iv_value TO lv_value_str_fltp.
    SPLIT lv_value_str_fltp AT 'E' INTO DATA(lv_number_fltp) DATA(lv_exponent).

    IF lv_exponent(1) = '+'.
      lv_decimals_count = 16 - lv_exponent+1.
      lv_digits_count   = lv_exponent+1 + 1.
    ELSE.
      lv_decimals_count = 14.
      lv_digits_count   = 1.
    ENDIF.

    IF lv_digits_count + lv_decimals_count > 15.
      lv_decimals_count = 15 - lv_digits_count.
    ENDIF.

    CREATE DATA lr_data TYPE p DECIMALS lv_decimals_count.
    ASSIGN lr_data->* TO <lv_data>.

    " Create decimal data
    TRY.
        <lv_data> = iv_value.

      CATCH cx_sy_conversion_overflow.
        RAISE EXCEPTION TYPE cx_ngc_core_chr_exception.
    ENDTRY.
    WRITE <lv_data> TO lv_value_str.

    " Format decimal data
    DATA(lv_regex_non_digit_or_decimal) = |[^\\d{ lv_decimal_sign }]|.
    REPLACE ALL OCCURRENCES OF REGEX lv_regex_non_digit_or_decimal IN lv_value_str WITH ' '.
    SPLIT lv_value_str AT lv_decimal_sign INTO DATA(lv_number) DATA(lv_decimals) IN CHARACTER MODE.
    SHIFT lv_number LEFT DELETING LEADING ' '.
    SHIFT lv_decimals RIGHT DELETING TRAILING '0'.
    SHIFT lv_decimals LEFT DELETING LEADING ' '.

    " Validate length
    IF strlen( lv_number ) > is_charc_header-charclength - is_charc_header-charcdecimals.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '009' ) TO et_message.
      RETURN.
    ENDIF.

    IF strlen( lv_decimals ) > is_charc_header-charcdecimals.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '010' ) TO et_message.
      RETURN.
    ENDIF.

  ENDMETHOD.