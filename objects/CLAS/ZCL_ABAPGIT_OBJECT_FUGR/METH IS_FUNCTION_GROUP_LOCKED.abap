  METHOD is_function_group_locked.

    DATA: lv_object TYPE eqegraarg.

    lv_object = |FG{ ms_item-obj_name }|.
    OVERLAY lv_object WITH '                                          '.
    lv_object = lv_object && '*'.

    rv_is_functions_group_locked = exists_a_lock_entry_for( iv_lock_object = 'EEUDB'
                                                            iv_argument    = lv_object ).

  ENDMETHOD.