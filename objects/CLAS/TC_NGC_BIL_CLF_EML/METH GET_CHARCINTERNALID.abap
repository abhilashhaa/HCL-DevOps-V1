  METHOD get_charcinternalid.

    SELECT SINGLE charcinternalid FROM i_clfncharacteristic
      INTO @rv_charcinternalid
      WHERE
        characteristic = @iv_characteristic.

    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      exp = 0
      msg = |Characteristic { iv_characteristic } should exist| ).

  ENDMETHOD.