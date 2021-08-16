  METHOD get_charcinternalid.

    CHECK iv_characteristic IS NOT INITIAL.

    DATA(lv_characteristic) = iv_characteristic.

    CONDENSE lv_characteristic NO-GAPS.

    SELECT SINGLE FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) "#EC CI_NOORDER
      FIELDS charcinternalid
      WHERE characteristic = @lv_characteristic
      INTO @rv_charcinternalid ##WARN_OK.

    IF sy-subrc IS NOT INITIAL.
      rv_charcinternalid = iv_characteristic.
    ENDIF.

  ENDMETHOD.