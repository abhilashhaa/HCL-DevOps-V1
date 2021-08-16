  METHOD zif_abapgit_object~is_locked.

    DATA: lv_argument TYPE eqegraarg.

    lv_argument = |PF{ ms_item-obj_name }|.
    OVERLAY lv_argument WITH '                                          *'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'EEUDB'
                                            iv_argument    = lv_argument ).

  ENDMETHOD.