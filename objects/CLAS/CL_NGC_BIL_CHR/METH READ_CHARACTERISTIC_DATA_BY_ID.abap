  METHOD read_characteristic_data_by_id.

    CLEAR: es_characteristic, et_characteristicdesc, et_characteristicref, et_characteristicrstrcn, et_characteristicrstrcn, et_characteristicvalue, et_characteristicvaluedesc.


    IF es_characteristic IS REQUESTED.
      SELECT SINGLE * FROM i_clfncharcforkeydatetp( p_keydate = @iv_keydate )
        INTO @es_characteristic
        WHERE
          charcinternalid = @iv_charcinternalid.
    ENDIF.

    IF et_characteristicrstrcn IS REQUESTED.
      SELECT * FROM i_clfncharcrstrcnforkeydatetp( p_keydate = @iv_keydate )
        INTO TABLE @et_characteristicrstrcn
        WHERE
          charcinternalid = @iv_charcinternalid.
    ENDIF.

    IF et_characteristicref IS REQUESTED.
      SELECT * FROM i_clfncharcrefforkeydatetp( p_keydate = @iv_keydate )
        INTO TABLE @et_characteristicref
        WHERE
        charcinternalid = @iv_charcinternalid AND
        charcreferencetable IS NOT NULL .
    ENDIF.

    IF et_characteristicdesc IS REQUESTED.
      SELECT * FROM i_clfncharcdescforkeydatetp( p_keydate = @iv_keydate )
        INTO TABLE @et_characteristicdesc
        WHERE
          charcinternalid = @iv_charcinternalid.
    ENDIF.

    IF et_characteristicvalue IS REQUESTED.
      SELECT * FROM i_clfncharcvalforkeydatetp( p_keydate = @iv_keydate )
        INTO TABLE @et_characteristicvalue
        WHERE
          charcinternalid = @iv_charcinternalid
        ORDER BY charcinternalid, charcvaluepositionnumber.
    ENDIF.

    IF et_characteristicvaluedesc IS REQUESTED.
      SELECT * FROM i_clfncharcvaldescforkeydatetp( p_keydate = @iv_keydate )
        INTO TABLE @et_characteristicvaluedesc
        WHERE
          charcinternalid = @iv_charcinternalid
        ORDER BY charcinternalid, language, charcvaluepositionnumber.
    ENDIF.

  ENDMETHOD.