  METHOD set_table_details.

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_util_chcktable
      )->set_parameter(
        name  = 'et_field_list'
        value = it_field_list
      )->set_parameter(
        name  = 'et_field_info'
        value = it_field_info ).
    mo_cut->mo_chr_util_chcktable->get_table_details( iv_table_name ).

  ENDMETHOD.