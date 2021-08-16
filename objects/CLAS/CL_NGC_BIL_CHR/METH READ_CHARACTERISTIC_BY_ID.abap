  METHOD read_characteristic_by_id.

    SELECT SINGLE * FROM i_clfncharcforkeydatetp( p_keydate = @iv_keydate )
      INTO @rs_characteristic
      WHERE
        charcinternalid = @iv_charcinternalid.

  ENDMETHOD.