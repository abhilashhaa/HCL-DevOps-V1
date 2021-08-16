  METHOD zif_abapgit_object~is_locked.

    DATA: lv_argument TYPE seqg3-garg.

    lv_argument = |PA{ ms_item-obj_name }|.
    OVERLAY lv_argument WITH '                                          '.
    lv_argument = lv_argument && '*'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'EEUDB'
                                            iv_argument    = lv_argument ).

  ENDMETHOD.