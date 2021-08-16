  METHOD zif_abapgit_object~is_locked.

    DATA: lv_argument TYPE seqg3-garg.

    lv_argument = ms_item-obj_name(15).
    lv_argument+15(1) = '*'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'ESICFSER'
                                            iv_argument    = lv_argument ).

  ENDMETHOD.