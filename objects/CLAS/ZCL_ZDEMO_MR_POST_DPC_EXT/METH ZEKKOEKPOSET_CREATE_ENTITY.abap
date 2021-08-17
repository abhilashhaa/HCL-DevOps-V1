  METHOD zekkoekposet_create_entity.
    DATA: ls_zekkoekpo LIKE er_entity.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_zekkoekpo ).

    ls_zekkoekpo-mandt = sy-mandt.

    er_entity = ls_zekkoekpo.

    INSERT INTO zekkoekpo VALUES ls_zekkoekpo.
  ENDMETHOD.