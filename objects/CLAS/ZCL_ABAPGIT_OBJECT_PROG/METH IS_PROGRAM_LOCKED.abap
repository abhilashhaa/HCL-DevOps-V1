  METHOD is_program_locked.

    rv_is_program_locked = exists_a_lock_entry_for( iv_lock_object = 'ESRDIRE'
                                                    iv_argument    = |{ ms_item-obj_name }| ).

  ENDMETHOD.