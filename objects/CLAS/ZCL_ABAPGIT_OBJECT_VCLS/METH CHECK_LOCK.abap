  METHOD check_lock.

    DATA:
      ls_rstable_key TYPE rstable, " Lock argument for table RSTABLE
      lv_argument    TYPE eqegraarg.

    " Set Values for generic table lock
    ls_rstable_key-tabname = iv_tabname.
    ls_rstable_key-varkey  = iv_argument.

    " include all sub keys
    lv_argument = ls_rstable_key.
    lv_argument = lv_argument && '*'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object         = 'E_TABLEE'
                                            iv_argument            = lv_argument ).

  ENDMETHOD.