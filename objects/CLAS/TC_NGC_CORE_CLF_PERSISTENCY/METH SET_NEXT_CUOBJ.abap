  METHOD set_next_cuobj.

    cl_abap_testdouble=>configure_call( mo_cut->mo_util )->returning( iv_cuobj ).
    mo_cut->mo_util->get_next_cuobj_from_nr( ).

  ENDMETHOD.