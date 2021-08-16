  METHOD setup_get_characteristics.

    cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
        name  = 'eo_clf_api_result'
        value = io_ngc_clf_api_result
    )->set_parameter(
        name  = 'et_characteristic'
        value = it_characteristic
    )->and_expect( ).
*    )->is_called_times( times = iv_number_of_expected_calling ).

    mo_ngc_classification->get_characteristics( ).

  ENDMETHOD.