  METHOD modify_charc_data.

    me->map_api_int_to_ext(
      EXPORTING
        is_charc_data     = is_charc_data
      IMPORTING
        et_charc          = DATA(lt_charc)
        et_charc_val_char = DATA(lt_charc_val_char)
        et_charc_val_curr = DATA(lt_charc_val_curr)
        et_charc_val_num  = DATA(lt_charc_val_num) ).

    IF iv_deep_insert = abap_true.
      rt_return = mo_ngc_db_access->create_characteristic(
        iv_testrun             = abap_true
        iv_changenumber        = is_charc_data-changenumber
        is_characteristic_bapi = lt_charc[ 1 ]
        it_charcdesc_bapi      = is_charc_data-charcdesc
        it_charcref_bapi       = is_charc_data-charcref
        it_charcrstrcn_bapi    = is_charc_data-charcrstr
        it_charcvalchar_bapi   = lt_charc_val_char
        it_charcvalnum_bapi    = lt_charc_val_num
        it_charcvalcurr_bapi   = lt_charc_val_curr
        it_charcvaldesc_bapi   = is_charc_data-charcvaldesc ).
    ELSE.
      rt_return = mo_ngc_db_access->change_characteristic(
        iv_testrun             = abap_true
        iv_changenumber        = is_charc_data-changenumber
        iv_characteristic      = lt_charc[ 1 ]-charact_name
        it_charc_bapi          = lt_charc
        it_charcdesc_bapi      = is_charc_data-charcdesc
        it_charcref_bapi       = is_charc_data-charcref
        it_charcrstrcn_bapi    = is_charc_data-charcrstr
        it_charcvalchar_bapi   = lt_charc_val_char
        it_charcvalnum_bapi    = lt_charc_val_num
        it_charcvalcurr_bapi   = lt_charc_val_curr
        it_charcvaldesc_bapi   = is_charc_data-charcvaldesc ).
    ENDIF.

  ENDMETHOD.