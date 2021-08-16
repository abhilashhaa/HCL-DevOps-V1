  METHOD setup_delete_time_value.

    cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
      EXPORTING
        name          = 'eo_clf_api_result'
        value         = io_clf_api_result
    )->set_parameter(
      EXPORTING
        name          = 'et_success_value'
        value         = it_success_value
    )->and_expect(
    )->is_called_times( times = iv_number_of_expected_calling ).

    mo_ngc_classification->delete_time_value( it_change_value = VALUE #( ) ).

  ENDMETHOD.