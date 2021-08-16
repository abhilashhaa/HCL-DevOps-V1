  METHOD update_op_get_assgnval_failure.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lv_charcdatatype) = if_ngc_c=>gc_charcdatatype-char.

    DATA(lt_test_data) = get_testdata_for_update( iv_charcdatatype = lv_charcdatatype ).
    DATA(lt_valuation_data) = get_valuation_data( iv_charcdatatype = lv_charcdatatype ).

    DATA(lo_clf_api_result) = setup_api_result(
      it_message = VALUE #(
        ( object_key       = lt_test_data[ 1 ]-clfnobjectid
          technical_object = lt_test_data[ 1 ]-clfnobjecttable
          msgty            = 'E' ) ) ).
    setup_get_assigned_values(
      iv_number_of_expected_calling = 1
      io_clf_api_result             = lo_clf_api_result
      it_valuation_data             = lt_valuation_data ).
    lo_clf_api_result = setup_api_result( ).
    setup_get_characteristics(
      iv_number_of_expected_calling = lines( lt_test_data )
      it_characteristic             = VALUE ngct_clf_characteristic_object( (
                                        charcinternalid       = lt_test_data[ 1 ]-charcinternalid
                                        characteristic_object = mo_ngc_characteristic ) )
      io_ngc_clf_api_result         = lo_clf_api_result ).
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