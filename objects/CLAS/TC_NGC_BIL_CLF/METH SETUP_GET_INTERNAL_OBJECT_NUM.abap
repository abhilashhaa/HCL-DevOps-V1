  METHOD SETUP_GET_INTERNAL_OBJECT_NUM.

    cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->returning(
      EXPORTING
        value         = it_obj_int_id
    )->and_expect(
    )->is_called_times( times = iv_number_of_expected_calling ).

    mo_ngc_classification->get_internal_object_number( ).

  ENDMETHOD.