  METHOD if_ngc_rap_chr_bapi_util~delete_characteristic.

    CALL FUNCTION 'BAPI_CHARACT_DELETE'
      EXPORTING
        charactname  = iv_characteristic
        changenumber = iv_changenumber
        testrun      = iv_testrun
      TABLES
        return       = rt_return.

  ENDMETHOD.