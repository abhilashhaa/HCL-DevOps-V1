  METHOD if_ngc_rap_chr_bapi_util~create_characteristic.

    DATA(lt_charcvalchar_bapi) = it_charcvalchar_bapi.
    DATA(lt_charcvaldesc_bapi) = it_charcvaldesc_bapi.
    DATA(lt_charcdesc_bapi)    = it_charcdesc_bapi.

    IF lt_charcdesc_bapi IS INITIAL.
      APPEND VALUE #( language_int = sy-langu description = 'Dummy description' ) TO lt_charcdesc_bapi.
    ENDIF.

    CALL FUNCTION 'BAPI_CHARACT_CREATE'
      EXPORTING
        charactdetail       = is_characteristic_bapi
        testrun             = iv_testrun
        changenumber        = iv_changenumber
*       keydate             =
      TABLES
        charactdescr        = lt_charcdesc_bapi
        charactvaluesnum    = it_charcvalnum_bapi
        charactvalueschar   = lt_charcvalchar_bapi
        charactvaluesdescr  = lt_charcvaldesc_bapi
        charactvaluescurr   = it_charcvalcurr_bapi
        charactreferences   = it_charcref_bapi
        charactrestrictions = it_charcrstrcn_bapi
        return              = rt_return.

  ENDMETHOD.