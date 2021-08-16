  METHOD zif_abapgit_object~is_locked.

    DATA: lv_object TYPE seqg3-garg.

    lv_object = |{ ms_item-obj_name }|.
    OVERLAY lv_object WITH '                              '.
    lv_object = lv_object && '*'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'EFPFORM'
                                            iv_argument    = lv_object ).

  ENDMETHOD.