  METHOD set_text_table.

    cl_abap_testdouble=>configure_call( mo_cut->mo_core_util
      )->set_parameter(
        name  = 'ev_texttable'
        value = iv_texttable
      )->set_parameter(
        name  = 'ev_checkfield'
        value = iv_checkfield ).
    mo_cut->mo_core_util->get_texttable( iv_table_name ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_core_util
      )->ignore_all_parameters(
      )->set_parameter(
        name  = 'ev_texttable'
        value = ''
      )->set_parameter(
        name  = 'ev_checkfield'
        value = '' ).
    mo_cut->mo_core_util->get_texttable( '' ).

  ENDMETHOD.