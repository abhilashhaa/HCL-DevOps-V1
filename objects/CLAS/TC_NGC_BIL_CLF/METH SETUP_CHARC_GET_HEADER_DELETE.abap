  METHOD setup_charc_get_header_delete.

    DO 5 TIMES.
      cl_abap_testdouble=>configure_call( mt_ngc_characteristic[ sy-index ]-characteristic_object )->ignore_all_parameters( )->returning(
        value = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[ sy-index ]
      )->and_expect(
      )->is_called_times( times = iv_number_of_expected_calling ).
      mt_ngc_characteristic[ sy-index ]-characteristic_object->get_header( ).
    ENDDO.

  ENDMETHOD.