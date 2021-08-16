  METHOD IF_NGC_CORE_UTIL~GET_NUMBER_SEPARATOR_SIGNS.

    IF mv_decimal_sign IS INITIAL OR
       mv_separator IS INITIAL.

      CALL FUNCTION 'CLSE_SELECT_USR01'
        EXPORTING
          username     = sy-uname
        IMPORTING
          decimal_sign = mv_decimal_sign
          separator    = mv_separator.

    ENDIF.

    ev_decimal_sign = mv_decimal_sign.
    ev_separator    = mv_separator.

  ENDMETHOD.