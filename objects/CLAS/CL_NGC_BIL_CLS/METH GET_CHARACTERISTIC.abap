  METHOD get_characteristic.

    IF iv_charcinternalid <> 0.
      SELECT SINGLE FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum )
        FIELDS characteristic
        WHERE charcinternalid = @iv_charcinternalid
        INTO @rv_characteristic.
    ELSE.
      IF iv_charcinternalid CO '0 '.
        CLEAR rv_characteristic.
      ELSE.
        rv_characteristic = iv_charcinternalid.
      ENDIF.
    ENDIF.

  ENDMETHOD.