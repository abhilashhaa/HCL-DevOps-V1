  METHOD setup_charc_get_header.

    cl_abap_testdouble=>configure_call( mo_ngc_characteristic
      )->ignore_all_parameters(
      )->returning(
        value = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[ charcdatatype = iv_charcdatatype ]
      )->and_expect(
      )->is_called_times( iv_number_of_expected_calling ).

    mo_ngc_characteristic->get_header( ).

  ENDMETHOD.