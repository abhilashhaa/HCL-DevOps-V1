  METHOD read_charc_data_by_id_incl_del.

    CLEAR: es_characteristic, et_characteristicdesc, et_characteristicref, et_characteristicrstrcn, et_characteristicrstrcn, et_characteristicvalue, et_characteristicvaluedesc.


    IF es_characteristic IS REQUESTED.
      SELECT SINGLE * FROM i_clfncharacteristic
        INTO CORRESPONDING FIELDS OF @es_characteristic
        WHERE charcinternalid   =  @iv_charcinternalid
          AND validitystartdate <= @iv_keydate
          AND validityenddate   >= @iv_keydate.
    ENDIF.

    IF et_characteristicrstrcn IS REQUESTED.
      SELECT * FROM i_clfncharcrestriction
        INTO CORRESPONDING FIELDS OF TABLE @et_characteristicrstrcn
        WHERE
          charcinternalid = @iv_charcinternalid.
    ENDIF.

    IF et_characteristicref IS REQUESTED.
      SELECT * FROM i_clfncharcreference
        INTO CORRESPONDING FIELDS OF TABLE @et_characteristicref
        WHERE
        charcinternalid = @iv_charcinternalid AND
        charcreferencetable IS NOT NULL .
    ENDIF.

    IF et_characteristicdesc IS REQUESTED.
      SELECT * FROM i_clfncharcdesc
        INTO CORRESPONDING FIELDS OF TABLE @et_characteristicdesc
        WHERE charcinternalid   =  @iv_charcinternalid
          AND validitystartdate <= @iv_keydate
          AND validityenddate   >= @iv_keydate.
    ENDIF.

    IF et_characteristicvalue IS REQUESTED.
      SELECT * FROM i_clfncharcvalue
        INTO CORRESPONDING FIELDS OF TABLE @et_characteristicvalue
        WHERE charcinternalid   =  @iv_charcinternalid
          AND validitystartdate <= @iv_keydate
          AND validityenddate   >= @iv_keydate
        ORDER BY charcinternalid, charcvaluepositionnumber.
    ENDIF.

    IF et_characteristicvaluedesc IS REQUESTED.
      SELECT * FROM i_clfncharcvaluedesc
        INTO CORRESPONDING FIELDS OF TABLE @et_characteristicvaluedesc
        WHERE charcinternalid   =  @iv_charcinternalid
          AND validitystartdate <= @iv_keydate
          AND validityenddate   >= @iv_keydate
        ORDER BY charcinternalid, language, charcvaluepositionnumber.
    ENDIF.

  ENDMETHOD.