  METHOD set_checktable_existing.

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_util_chcktable
      )->returning( abap_true ).
    mo_cut->mo_chr_util_chcktable->checktable_exsists( iv_checktable ).

  ENDMETHOD.