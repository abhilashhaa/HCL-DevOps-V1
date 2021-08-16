  METHOD table_exists.

    DATA: lv_tabname TYPE dd02l-tabname.

    SELECT SINGLE tabname FROM dd02l INTO lv_tabname
      WHERE tabname = zcl_abapgit_persistence_db=>c_tabname.
    rv_exists = boolc( sy-subrc = 0 ).

  ENDMETHOD.