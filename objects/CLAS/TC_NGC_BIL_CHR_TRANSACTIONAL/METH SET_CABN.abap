  METHOD set_cabn.

    cl_abap_testdouble=>configure_call( mo_cut->mo_ngc_db_access )->returning( it_cabn ).
    mo_cut->mo_ngc_db_access->read_charc_from_buffer( ).

  ENDMETHOD.