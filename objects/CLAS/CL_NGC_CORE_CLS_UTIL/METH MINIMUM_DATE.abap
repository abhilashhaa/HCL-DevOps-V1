  METHOD MINIMUM_DATE.
    IF ( iv_date1 < iv_date2 AND iv_date1 < iv_date3 ).
      rv_min_date = iv_date1.
      RETURN.
    ELSE.
      IF ( iv_date2 < iv_date3 ).
        rv_min_date = iv_date2.
        RETURN.
      ELSE.
        rv_min_date = iv_date3.
        RETURN.
      ENDIF.
    ENDIF.
  ENDMETHOD.