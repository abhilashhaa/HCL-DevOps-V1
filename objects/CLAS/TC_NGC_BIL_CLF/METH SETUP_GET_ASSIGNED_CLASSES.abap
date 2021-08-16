  METHOD setup_get_assigned_classes.

    cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
      EXPORTING
        name          = 'et_classification_data'
        value         = it_classification_data
    )->set_parameter(
      EXPORTING
        name          = 'et_assigned_class'
        value         = it_assigned_class
    )->and_expect(
    )->is_called_times( times = iv_number_of_expected_calling ).

    mo_ngc_classification->get_assigned_classes( ).

  ENDMETHOD.