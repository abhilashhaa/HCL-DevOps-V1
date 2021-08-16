  METHOD GET_DATE_BOUNDARIES.

* get date from value and adjust lower boundary
    " set min value
    IF iv_charcvaluedependency EQ 6 OR iv_charcvaluedependency EQ 7.
      ev_charcfromdate = if_ngc_c=>gc_date_min.
    ELSE.
      me->convert_fltp_to_date(
        EXPORTING
          iv_fltp_value    = iv_charcfromnumericvalue
        RECEIVING
          rv_date          = ev_charcfromdate
        EXCEPTIONS
          conversion_error = 1
      ).
      IF sy-subrc EQ 0.
        " increase: greater than (GT)
        IF iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 5 OR iv_charcvaluedependency EQ 8.
          ev_charcfromdate = ev_charcfromdate + 1.
        ENDIF.
      ELSE.
        RETURN.
      ENDIF.
    ENDIF.

* get date to value and adjust upper boundary
    " set max value
    IF iv_charcvaluedependency EQ 8 OR iv_charcvaluedependency EQ 9.
      ev_charctodate = if_ngc_c=>gc_date_max.
    ELSE.
      me->convert_fltp_to_date(
        EXPORTING
          iv_fltp_value    = iv_charctonumericvalue
        RECEIVING
          rv_date          = ev_charctodate
        EXCEPTIONS
          conversion_error = 1
      ).
      IF sy-subrc EQ 0.
        " decrease: lower than (LT)
        IF iv_charcvaluedependency EQ 2 OR iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 6.
          ev_charctodate = ev_charctodate - 1.
        ENDIF.
      ELSE.
        CLEAR ev_charcfromdate.
      ENDIF.
    ENDIF.

  ENDMETHOD.