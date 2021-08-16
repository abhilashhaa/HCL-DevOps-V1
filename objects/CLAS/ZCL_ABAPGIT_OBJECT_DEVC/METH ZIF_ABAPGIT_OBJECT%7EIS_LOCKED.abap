  METHOD zif_abapgit_object~is_locked.

    DATA: lv_object TYPE eqegraarg.

    lv_object = |DV{ ms_item-obj_name }|.
    OVERLAY lv_object WITH '                                          '.
    lv_object = lv_object && '*'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'EEUDB'
                                            iv_argument    = lv_object ).

  ENDMETHOD.