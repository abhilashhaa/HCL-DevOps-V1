  METHOD setup_get_assigned_values.

    cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
      EXPORTING
        name          = 'eo_clf_api_result'
        value         = io_clf_api_result
    )->set_parameter(
      EXPORTING
        name          = 'et_valuation_data'
        value         = it_valuation_data
    )->and_expect(
    )->is_called_times( times = iv_number_of_expected_calling ).

   mo_ngc_classification->get_assigned_values( ).

  ENDMETHOD.