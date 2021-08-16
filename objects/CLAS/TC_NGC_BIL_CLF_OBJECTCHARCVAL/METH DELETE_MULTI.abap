  METHOD delete_multi.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*


    DATA(lt_test_data) = th_ngc_bil_clf_data=>gt_objectcharcval_delete_multi.

    DATA(lo_clf_api_result) = setup_api_result( ).

    setup_charc_get_header_delete( iv_number_of_expected_calling = 1 ).

    setup_get_characteristics(
      iv_number_of_expected_calling = 1
      it_characteristic             = mt_ngc_characteristic
      io_ngc_clf_api_result         = lo_clf_api_result ).

    setup_get_assigned_values(
      iv_number_of_expected_calling = 1
      io_clf_api_result             = lo_clf_api_result
      it_valuation_data             = th_ngc_bil_clf_data=>gt_objectcharcval_val_data_mul ).

    setup_delete_char_value(
      iv_number_of_expected_calling = 1
      io_clf_api_result             = lo_clf_api_result
      it_success_value              = VALUE #( )
    ).

    setup_delete_num_value(
      iv_number_of_expected_calling = 1
      io_clf_api_result             = lo_clf_api_result
      it_success_value              = VALUE #( )
    ).

    setup_delete_curr_value(
      iv_number_of_expected_calling = 1
      io_clf_api_result             = lo_clf_api_result
      it_success_value              = VALUE #( )
    ).

    setup_delete_date_value(
      iv_number_of_expected_calling = 1
      io_clf_api_result             = lo_clf_api_result
      it_success_value              = VALUE #( )
    ).

    setup_delete_time_value(
      iv_number_of_expected_calling = 1
      io_clf_api_result             = lo_clf_api_result
      it_success_value              = VALUE #( )
    ).

    setup_api_read(
      is_classification_key = VALUE #( object_key       = lt_test_data[ 1 ]-clfnobjectid
                                       technical_object = lt_test_data[ 1 ]-clfnobjecttable
                                       change_number    = space
                                       key_date         = sy-datum )
      io_ngc_clf_api_result = lo_clf_api_result ).

    get_responses(
      IMPORTING
        es_reported = DATA(ls_reported)
        es_failed   = DATA(ls_failed) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~delete_objcharcval(
      EXPORTING
        it_input    = lt_test_data
      IMPORTING
        es_failed   = ls_failed
        es_reported = ls_reported ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    verify_classification_setup( ).

    DO 5 TIMES.
      cl_abap_testdouble=>verify_expectations( double = mt_ngc_characteristic[ sy-index ]-characteristic_object ).
    ENDDO.

  ENDMETHOD.