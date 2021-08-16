  METHOD GET_TIME_BOUNDARIES.

* get time from value and adjust lower boundary
    " set min value
    IF iv_charcvaluedependency EQ 6 OR iv_charcvaluedependency EQ 7.
      ev_charcfromtime = if_ngc_c=>gc_time_min.
    ELSE.
      me->convert_fltp_to_time(
        EXPORTING
          iv_fltp_value    = iv_charcfromnumericvalue
        RECEIVING
          rv_time          = ev_charcfromtime
        EXCEPTIONS
          conversion_error = 1
      ).

      IF sy-subrc EQ 0.
        " increase: greater than (GT)
        IF iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 5 OR iv_charcvaluedependency EQ 8.
          ev_charcfromtime = ev_charcfromtime + 1.
        ENDIF.
      ELSE.
        RETURN.
      ENDIF.
    ENDIF.

* get time to value and adjust upper boundary
    " set max value
    IF iv_charcvaluedependency EQ 8 OR iv_charcvaluedependency EQ 9.
      ev_charctotime = if_ngc_c=>gc_time_max.
    ELSE.
      me->convert_fltp_to_time(
        EXPORTING
          iv_fltp_value    = iv_charctonumericvalue
        RECEIVING
          rv_time          = ev_charctotime
        EXCEPTIONS
          conversion_error = 1
      ).
      IF sy-subrc EQ 0.
        " decrease: lower than (LE)
        IF iv_charcvaluedependency EQ 2 OR iv_charcvaluedependency EQ 4 OR iv_charcvaluedependency EQ 6.
          ev_charctotime = ev_charctotime - 1.
        ENDIF.
      ELSE.
        CLEAR ev_charcfromtime.
      ENDIF.
    ENDIF.

  ENDMETHOD.