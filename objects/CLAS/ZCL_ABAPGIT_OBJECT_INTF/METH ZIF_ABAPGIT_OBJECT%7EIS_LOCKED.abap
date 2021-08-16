  METHOD zif_abapgit_object~is_locked.

    DATA: lv_object TYPE eqegraarg.

    lv_object = |{ ms_item-obj_name }|.
    OVERLAY lv_object WITH '==============================P'.
    lv_object = lv_object && '*'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'ESEOCLASS'
                                            iv_argument    = lv_object ).

  ENDMETHOD.