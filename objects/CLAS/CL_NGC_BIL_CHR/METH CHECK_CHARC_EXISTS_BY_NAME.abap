  METHOD check_charc_exists_by_name.

    SELECT SINGLE @abap_true FROM i_clfncharcforkeydatetp( p_keydate = @iv_keydate )
      INTO @rv_exists
      WHERE
        characteristic = @iv_characteristic.

  ENDMETHOD.