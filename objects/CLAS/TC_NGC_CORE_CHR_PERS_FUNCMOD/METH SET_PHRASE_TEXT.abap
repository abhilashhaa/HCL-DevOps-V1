  METHOD set_phrase_text.

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_util_funcmod )->set_parameter(
      name  = 'ev_phrase_code'
      value = iv_phrase_code ).
    mo_cut->mo_chr_util_funcmod->read_phrased_text( iv_phrase_key ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_util_funcmod
      )->ignore_all_parameters(
      )->set_parameter(
        name  = 'ev_phrase_code'
        value = '' ).
    mo_cut->mo_chr_util_funcmod->read_phrased_text( '' ).

  ENDMETHOD.