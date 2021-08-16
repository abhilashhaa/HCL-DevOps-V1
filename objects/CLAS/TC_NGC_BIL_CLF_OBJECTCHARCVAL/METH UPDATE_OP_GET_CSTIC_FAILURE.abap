  METHOD update_op_get_cstic_failure.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_test_data) = get_testdata_for_update( iv_charcdatatype = if_ngc_c=>gc_charcdatatype-char ).

    DATA(lo_clf_api_result) = setup_api_result(
      it_message = VALUE #(
        ( object_key       = lt_test_data[ 1 ]-clfnobjectid
          technical_object = lt_test_data[ 1 ]-clfnobjecttable
          msgty            = 'E' ) ) ).
    setup_get_characteristics(
      iv_number_of_expected_calling = lines( lt_test_data )
      it_characteristic             = VALUE #( )
      io_ngc_clf_api_result         = lo_clf_api_result ).
    lo_clf_api_result = setup_api_result( ).
    setup_api_read(
      is_classification_key = VALUE #( object_key       = lt_test_data[ 1 ]-clfnobjectid
                                       technical_object = lt_test_data[ 1 ]-clfnobjecttable
                                       change_number    = space
                                       key_date         = sy-datum )
      io_ngc_clf_api_result = lo_clf_api_result ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~update_objcharcval(
      EXPORTING
        it_input    = lt_test_data
      IMPORTING
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_not_initial(
      act = ls_failed
      msg = 'Failed entry was expected' ).

    cl_abap_unit_assert=>assert_not_initial(
      act = ls_reported
      msg = 'Reported entry was expected' ).

    verify_classification_setup( ).

  ENDMETHOD.