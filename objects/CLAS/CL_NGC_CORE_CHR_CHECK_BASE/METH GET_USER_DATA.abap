  METHOD get_user_data.

    CALL FUNCTION 'CLSE_SELECT_USR01'
      EXPORTING
        username     = sy-uname
      IMPORTING
        decimal_sign = ev_decimal_sign
        separator    = ev_separator.

  ENDMETHOD.