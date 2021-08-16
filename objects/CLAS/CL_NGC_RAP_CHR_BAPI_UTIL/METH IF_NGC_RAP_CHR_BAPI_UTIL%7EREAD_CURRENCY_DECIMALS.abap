  METHOD if_ngc_rap_chr_bapi_util~read_currency_decimals.

    CALL FUNCTION 'TCURX_READ'
      EXPORTING
        i_curr    = iv_currency
      IMPORTING
        e_currdec = rv_decimals.

  ENDMETHOD.