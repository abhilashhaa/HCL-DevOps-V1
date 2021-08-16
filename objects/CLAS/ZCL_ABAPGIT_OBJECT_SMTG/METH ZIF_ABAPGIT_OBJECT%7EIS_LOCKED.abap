  METHOD zif_abapgit_object~is_locked.
    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'E_SMTG'
                                            iv_argument    = |{ mv_template_id }| ).
  ENDMETHOD.