  METHOD zif_abapgit_object~is_locked.

    " There's no object specific locking. Just a global one.
    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'E_SPERSREG' ).

  ENDMETHOD.