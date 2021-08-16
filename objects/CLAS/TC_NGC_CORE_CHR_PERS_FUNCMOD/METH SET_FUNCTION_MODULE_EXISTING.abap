  METHOD set_function_module_existing.

    cl_abap_testdouble=>configure_call( mo_cut->mo_core_util )->returning( abap_true ).
    mo_cut->mo_core_util->function_exists( iv_function_name ).

  ENDMETHOD.