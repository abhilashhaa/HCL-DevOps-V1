  METHOD validate_day.

    DATA:
      lv_date_string TYPE string.


    " Validate days
    CASE iv_date+4(2).
        " 31 day months
      WHEN '01' OR '03' OR '05' OR '07' OR '08' OR '10' OR '12'.
        IF iv_date+6(2) > 31.
          APPEND VALUE #(
            key_date        = sy-datum
            charcinternalid = is_charc_header-charcinternalid
            msgty           = if_ngc_c=>gc_message_severity-error
            msgid           = 'NGC_CORE_CHR'
            msgno           = '018' ) TO et_message.
          RETURN.
        ENDIF.

        " 30 day months
      WHEN '04' OR '06' OR '09' OR '11'.
        IF iv_date+6(2) > 30.
          APPEND VALUE #(
            key_date        = sy-datum
            charcinternalid = is_charc_header-charcinternalid
            msgty           = if_ngc_c=>gc_message_severity-error
            msgid           = 'NGC_CORE_CHR'
            msgno           = '018' ) TO et_message.
          RETURN.
        ENDIF.

        " February (leap years)
      WHEN '02'.
        " External conversion doesn't check value
        CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
          EXPORTING
            date_internal = iv_date
          IMPORTING
            date_external = lv_date_string
          EXCEPTIONS
            OTHERS        = 4.

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_ngc_core_chr_exception.
        ENDIF.

        " Internal conversion will check value
        CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
          EXPORTING
            date_external = lv_date_string
          EXCEPTIONS
            OTHERS        = 4.

        IF sy-subrc <> 0.
          APPEND VALUE #(
            key_date        = sy-datum
            charcinternalid = is_charc_header-charcinternalid
            msgty           = if_ngc_c=>gc_message_severity-error
            msgid           = 'NGC_CORE_CHR'
            msgno           = '018' ) TO et_message.
          RETURN.
        ENDIF.
    ENDCASE.

  ENDMETHOD.