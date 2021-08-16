  METHOD zif_abapgit_persist_repo~lock.

    mo_db->lock( iv_mode  = iv_mode
                 iv_type  = zcl_abapgit_persistence_db=>c_type_repo
                 iv_value = iv_key ).

  ENDMETHOD.