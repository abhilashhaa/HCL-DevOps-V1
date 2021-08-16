  METHOD set_function_module_values.

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_util_funcmod
      )->returning( it_values ).
    mo_cut->mo_chr_util_funcmod->call_f4_fm(
      iv_function_name   = iv_function_name
      iv_characteristic  = iv_characteristic
      iv_charcinternalid = iv_charcinternalid ).

  ENDMETHOD.