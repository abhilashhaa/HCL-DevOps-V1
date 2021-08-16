  METHOD check_charc_exists_by_id.

    SELECT SINGLE @abap_true FROM i_clfncharcforkeydatetp( p_keydate = @iv_keydate )
      INTO @rv_exists
      WHERE
        charcinternalid = @iv_charcinternalid.

  ENDMETHOD.