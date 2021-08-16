  METHOD zif_abapgit_object~is_locked.
    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'HRSOBJECT'
                                            iv_argument = c_object_type_task && mv_objid ).
  ENDMETHOD.