  METHOD GET_CURRENCY_BOUNDARIES.

    DATA:
      lv_inc TYPE auspext_curr_from VALUE 1,
      lv_max TYPE auspext_curr_from.

* calculate increment
    lv_inc = lv_inc / ipow( base = 10 exp = 2 ).

* calculate min/max
    IF iv_charcvaluedependency CA '6789' AND iv_charclength IS SUPPLIED.
      lv_max = ipow( base = 10 exp = ( iv_charclength - 2 ) ) - lv_inc.
    ENDIF.

* get currency from value and adjust lower boundary
    " set min value
    IF iv_charcvaluedependency EQ 6 OR iv_charcvaluedependency EQ 7.
      ev_charcfromamount = lv_max * -1.
    ELSE.
      me->convert_fltp_to_curr(
        EXPORTING
          iv_currency      = iv_currency
          iv_fltp_value    = iv_charcfromnumericvalue
        RECEIVING
          rv_curr_value    = ev_charcfromamount
        EXCEPTIONS
          conversion_error = 1
       ).
      IF sy-subrc EQ 0.
        " increase: greater than (GT)
        IF iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 5 OR iv_charcvaluedependency EQ 8.
          ev_charcfromamount = ev_charcfromamount + lv_inc.
        ENDIF.
      ELSE.
        RAISE conversion_error.
      ENDIF.
    ENDIF.

* get currency and adjust lower / upper boundaries
    " set max value
    IF iv_charcvaluedependency EQ 8 OR iv_charcvaluedependency EQ 9.
      ev_charctoamount = lv_max.
    ELSE.
      me->convert_fltp_to_curr(
        EXPORTING
          iv_currency      = iv_currency
          iv_fltp_value    = iv_charctonumericvalue
        RECEIVING
          rv_curr_value    = ev_charctoamount
        EXCEPTIONS
          conversion_error = 1
       ).
      IF sy-subrc EQ 0.
        " decrease: lower than (LT)
        IF iv_charcvaluedependency EQ 2 OR iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 6.
          ev_charctoamount = ev_charctoamount - lv_inc.
        ENDIF.
      ELSE.
        CLEAR ev_charcfromamount.
        RAISE conversion_error.
      ENDIF.
    ENDIF.

  ENDMETHOD.