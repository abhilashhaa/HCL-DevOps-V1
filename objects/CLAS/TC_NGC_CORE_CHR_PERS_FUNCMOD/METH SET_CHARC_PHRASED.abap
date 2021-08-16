  METHOD set_charc_phrased.

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_util_funcmod )->returning( abap_true ).
    mo_cut->mo_chr_util_funcmod->check_charc_is_phrased( iv_charcinternalid ).

  ENDMETHOD.