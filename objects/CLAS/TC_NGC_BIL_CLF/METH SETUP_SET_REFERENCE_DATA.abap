  METHOD setup_set_reference_data.

    cl_abap_testdouble=>configure_call( mo_ngc_classification
      )->ignore_all_parameters(
      )->and_expect(
      )->is_called_times( times = iv_number_of_expected_calling ).

    mo_ngc_classification->set_reference_data(
      EXPORTING
        iv_charcreferencetable = VALUE #( )
        ir_data                = VALUE #( )
    ).

  ENDMETHOD.