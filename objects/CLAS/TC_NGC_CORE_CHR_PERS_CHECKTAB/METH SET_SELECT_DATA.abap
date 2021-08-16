  METHOD set_select_data.

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_util_chcktable
      )->set_parameter(
        name  = 'et_values'
        value = it_values ).
    mo_cut->mo_chr_util_chcktable->select_table_data( iv_table_name ).

  ENDMETHOD.