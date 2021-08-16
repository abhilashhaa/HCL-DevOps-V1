  METHOD GET_DECIMAL_BOUNDARIES.

    DATA: lv_inc TYPE auspext_dec_from VALUE 1,
          lv_max TYPE auspext_dec_from.

* calculate increment
    lv_inc = lv_inc / ipow( base = 10 exp = iv_charcdecimals ).

* calculate min/max
    IF iv_charcvaluedependency CA '6789' AND iv_charclength IS SUPPLIED.
      lv_max = ipow( base = 10 exp = ( iv_charclength - iv_charcdecimals ) ) - lv_inc.
    ENDIF.

* get decimal from and adjust lower boundary
    " set min value
    IF iv_charcvaluedependency EQ 6 OR iv_charcvaluedependency EQ 7.
      ev_charcfromdecimalvalue = lv_max * -1.
    ELSE.
      me->convert_fltp_to_dec(
        EXPORTING
          iv_fltp_value    = iv_charcfromnumericvalue
          iv_decimals      = iv_charcdecimals
        RECEIVING
          rv_dec_value     = ev_charcfromdecimalvalue
        EXCEPTIONS
          conversion_error = 1
      ).
      IF sy-subrc EQ 0.
        " increase: greater than (GT)
        IF iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 5 OR iv_charcvaluedependency EQ 8.
          ev_charcfromdecimalvalue = ev_charcfromdecimalvalue + lv_inc.
        ENDIF.
      ELSE.
        RETURN.
      ENDIF.
    ENDIF.

* get decimal to and adjust upper boundary
    " set max value
    IF iv_charcvaluedependency EQ 8 OR iv_charcvaluedependency EQ 9.
      ev_charctodecimalvalue = lv_max.
    ELSE.
      me->convert_fltp_to_dec(
        EXPORTING
          iv_fltp_value    = iv_charctonumericvalue
          iv_decimals      = iv_charcdecimals
        RECEIVING
          rv_dec_value     = ev_charctodecimalvalue
        EXCEPTIONS
          conversion_error = 1
      ).
      IF sy-subrc EQ 0.
        " decrease: lower than (LE)
        IF iv_charcvaluedependency EQ 2 OR iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 6.
          ev_charctodecimalvalue = ev_charctodecimalvalue - lv_inc.
        ENDIF.
      ELSE.
        CLEAR ev_charcfromdecimalvalue.
      ENDIF.
    ENDIF.

  ENDMETHOD.