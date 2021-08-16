  METHOD modify.

    ASSERT NOT is_data-key IS INITIAL.

    mo_db->modify(
      iv_type  = zcl_abapgit_persistence_db=>c_type_background
      iv_value = is_data-key
      iv_data  = to_xml( is_data ) ).

    DELETE mt_jobs WHERE key = is_data-key.
    APPEND is_data TO mt_jobs.

  ENDMETHOD.