  METHOD setup_change_values.

    cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
      EXPORTING
        name          = 'eo_clf_api_result'
        value         = io_clf_api_result
    )->set_parameter(
      EXPORTING
        name          = 'et_change_value'
        value         = it_change_value
    )->and_expect(
    )->is_called_times( times = iv_number_of_expected_calling ).

    mo_ngc_classification->change_values( it_change_value = VALUE #( ) ).

  ENDMETHOD.