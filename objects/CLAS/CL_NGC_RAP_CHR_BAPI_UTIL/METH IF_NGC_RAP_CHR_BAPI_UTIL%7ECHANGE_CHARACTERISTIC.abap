  METHOD if_ngc_rap_chr_bapi_util~change_characteristic.

    DATA(lt_charc_bapi)        = it_charc_bapi.
    DATA(lt_charcvalchar_bapi) = it_charcvalchar_bapi.
    DATA(lt_charcvalnum_bapi)  = it_charcvalnum_bapi.
    DATA(lt_charcvalcurr_bapi) = it_charcvalcurr_bapi.
    DATA(lt_charcvaldesc_bapi) = it_charcvaldesc_bapi.
    DATA(lt_charcref_bapi)     = it_charcvaldesc_bapi.
    DATA(lt_charcdesc_bapi)    = it_charcdesc_bapi.
    DATA(lt_charcrstrcn_bapi)  = it_charcrstrcn_bapi.

    CALL FUNCTION 'BAPI_CHARACT_CHANGE'
      EXPORTING
        charactname            = iv_characteristic
        testrun                = iv_testrun
        changenumber           = iv_changenumber
*       keydate                = SY-DATUM    " Date
      TABLES
        charactdetailnew       = lt_charc_bapi
        charactdescrnew        = lt_charcdesc_bapi
        charactvaluesnumnew    = lt_charcvalnum_bapi
        charactvaluescharnew   = lt_charcvalchar_bapi
        charactvaluescurrnew   = lt_charcvalcurr_bapi
        charactvaluesdescrnew  = lt_charcvaldesc_bapi
        charactreferencesnew   = it_charcref_bapi
        charactrestrictionsnew = lt_charcrstrcn_bapi
        return                 = rt_return.

  ENDMETHOD.