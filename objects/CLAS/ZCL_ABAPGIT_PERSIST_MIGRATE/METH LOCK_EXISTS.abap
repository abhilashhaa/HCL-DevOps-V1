  METHOD lock_exists.

    DATA: lv_viewname TYPE dd25l-viewname.


    SELECT SINGLE viewname FROM dd25l INTO lv_viewname
      WHERE viewname = zcl_abapgit_persistence_db=>c_lock.
    rv_exists = boolc( sy-subrc = 0 ).

  ENDMETHOD.