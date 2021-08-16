  METHOD SETUP_CLASS_REMOVE.

    cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
      EXPORTING
        name          = 'eo_clf_api_result'
        value         = io_ngc_clf_api_result
    )->and_expect(
    )->is_called_times( times = iv_number_of_expected_calling ).

    mo_ngc_classification->remove_classes_by_int_key(
      EXPORTING
        it_class_int_key  = VALUE #( )
    ).

  ENDMETHOD.