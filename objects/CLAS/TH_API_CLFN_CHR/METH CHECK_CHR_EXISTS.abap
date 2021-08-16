  METHOD check_chr_exists.

    SELECT SINGLE @abap_true FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum )
      INTO @rv_exists
      WHERE
        characteristic = @iv_characteristic.

  ENDMETHOD.