  METHOD zif_abapgit_object~is_locked.
    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'E_SMSTYLE'
                                            iv_argument    = |{ ms_item-obj_name }| ).
  ENDMETHOD.