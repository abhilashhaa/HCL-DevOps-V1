  METHOD CALCULATE_VALUATION_EXTENSION.

    CASE is_characteristic_header-charcdatatype.
        " convert float values to numeric type
      WHEN if_ngc_c=>gc_charcdatatype-num.
        IF cs_valuation_data-charcvaluedependency <> if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
          me->get_decimal_boundaries(
            EXPORTING
              iv_charcfromnumericvalue = cs_valuation_data-charcfromnumericvalue
              iv_charctonumericvalue   = cs_valuation_data-charctonumericvalue
              iv_charcvaluedependency  = cs_valuation_data-charcvaluedependency
              iv_charcdecimals         = is_characteristic_header-charcdecimals
              iv_charclength           = is_characteristic_header-charclength
            IMPORTING
              ev_charcfromdecimalvalue = cs_valuation_data-charcfromdecimalvalue
              ev_charctodecimalvalue   = cs_valuation_data-charctodecimalvalue
          ).
        ELSE.
          me->convert_fltp_to_dec(
            EXPORTING
              iv_fltp_value    = cs_valuation_data-charcfromnumericvalue
              iv_decimals      = is_characteristic_header-charcdecimals
            RECEIVING
              rv_dec_value     = cs_valuation_data-charcfromdecimalvalue
            EXCEPTIONS
              conversion_error = 1
          ).
          IF sy-subrc = 0.
            cs_valuation_data-charctodecimalvalue = cs_valuation_data-charcfromdecimalvalue.
          ENDIF.
        ENDIF.
        " convert float values to currency type
      WHEN if_ngc_c=>gc_charcdatatype-curr.
        cs_valuation_data-currency = is_characteristic_header-charcvalueunit." set currency key
        IF cs_valuation_data-charcvaluedependency <> if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
          me->get_currency_boundaries(
            EXPORTING
              iv_charcfromnumericvalue = cs_valuation_data-charcfromnumericvalue
              iv_charctonumericvalue   = cs_valuation_data-charctonumericvalue
              iv_charcvaluedependency  = cs_valuation_data-charcvaluedependency
              iv_currency              = cs_valuation_data-currency
              iv_charclength           = is_characteristic_header-charclength
            IMPORTING
              ev_charcfromamount       = cs_valuation_data-charcfromamount
              ev_charctoamount         = cs_valuation_data-charctoamount
            EXCEPTIONS
              conversion_error = 1
          ).
          IF sy-subrc <> 0.
            CLEAR: cs_valuation_data-currency,
                   cs_valuation_data-charcfromamount,
                   cs_valuation_data-charctoamount.
          ENDIF.
        ELSE.
          me->convert_fltp_to_curr(
            EXPORTING
              iv_currency      = cs_valuation_data-currency
              iv_fltp_value    = cs_valuation_data-charcfromnumericvalue
            RECEIVING
              rv_curr_value    = cs_valuation_data-charcfromamount
            EXCEPTIONS
              conversion_error = 1
           ).
          IF sy-subrc = 0.
            cs_valuation_data-charctoamount = cs_valuation_data-charcfromamount.
          ELSE.
            CLEAR: cs_valuation_data-currency.
          ENDIF.
        ENDIF.
        " convert float values to date type
      WHEN if_ngc_c=>gc_charcdatatype-date.
        IF cs_valuation_data-charcvaluedependency <> if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
          me->get_date_boundaries(
            EXPORTING
              iv_charcfromnumericvalue = cs_valuation_data-charcfromnumericvalue
              iv_charctonumericvalue   = cs_valuation_data-charctonumericvalue
              iv_charcvaluedependency  = cs_valuation_data-charcvaluedependency
            IMPORTING
              ev_charcfromdate         = cs_valuation_data-charcfromdate
              ev_charctodate           = cs_valuation_data-charctodate
            ).
        ELSE.
          me->convert_fltp_to_date(
            EXPORTING
              iv_fltp_value    = cs_valuation_data-charcfromnumericvalue
            RECEIVING
              rv_date          = cs_valuation_data-charcfromdate
            EXCEPTIONS
              conversion_error = 1
          ).
          IF sy-subrc = 0.
            cs_valuation_data-charctodate = cs_valuation_data-charcfromdate.
          ENDIF.
        ENDIF.
        " convert float values to time data type
      WHEN if_ngc_c=>gc_charcdatatype-time.
        IF cs_valuation_data-charcvaluedependency <> if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
          me->get_time_boundaries(
            EXPORTING
              iv_charcfromnumericvalue = cs_valuation_data-charcfromnumericvalue
              iv_charctonumericvalue   = cs_valuation_data-charctonumericvalue
              iv_charcvaluedependency  = cs_valuation_data-charcvaluedependency
            IMPORTING
              ev_charcfromtime         = cs_valuation_data-charcfromtime
              ev_charctotime           = cs_valuation_data-charctotime
            ).
        ELSE.
          me->convert_fltp_to_time(
            EXPORTING
              iv_fltp_value    = cs_valuation_data-charcfromnumericvalue
            RECEIVING
              rv_time          = cs_valuation_data-charcfromtime
            EXCEPTIONS
              conversion_error = 1
          ).
          IF sy-subrc = 0.
            cs_valuation_data-charctotime = cs_valuation_data-charcfromtime.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.