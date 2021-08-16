  METHOD set_characteristic_data.

    cl_abap_testdouble=>configure_call( mo_cut->mo_chr_persistency
      )->set_parameter(
        name  = 'et_characteristic'
        value = it_characteristic
      )->set_parameter(
        name  = 'et_characteristic_value'
        value = it_charc_value
      )->set_parameter(
        name  = 'et_characteristic_reference'
        value = it_charc_ref ).
    mo_cut->mo_chr_persistency->read_by_internal_key(
      EXPORTING
        it_key           = it_charc_key
        iv_skip_external = abap_true ).

  ENDMETHOD.