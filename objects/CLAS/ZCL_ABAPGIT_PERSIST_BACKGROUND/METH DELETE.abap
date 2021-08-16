  METHOD delete.

    TRY.
        mo_db->read( iv_type  = zcl_abapgit_persistence_db=>c_type_background
                     iv_value = iv_key ).
      CATCH zcx_abapgit_not_found.
        RETURN.
    ENDTRY.

    mo_db->delete( iv_type  = zcl_abapgit_persistence_db=>c_type_background
                   iv_value = iv_key ).

    DELETE mt_jobs WHERE key = iv_key.

  ENDMETHOD.