  METHOD create_single_value.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_test_data) = get_testdata_for_create( iv_charcdatatype = iv_charcdatatype ).

    DATA(lo_clf_api_result) = setup_api_result( ).
    setup_charc_get_header( iv_number_of_expected_calling = lines( lt_test_data ) iv_charcdatatype = iv_charcdatatype ).
    setup_set_value(
      iv_charcdatatype              = iv_charcdatatype
      iv_number_of_expected_calling = 1
      it_test_data                  = lt_test_data
      io_clf_api_result             = lo_clf_api_result
    ).
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

    mo_cut->if_ngc_bil_clf~create_objcharcval(
      EXPORTING
        it_input    = lt_test_data
      IMPORTING
        es_mapped   = DATA(ls_mapped)
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act = COND abap_bool( WHEN lines( ls_mapped-objectcharcvalue ) = lines( lt_test_data ) THEN abap_true ELSE abap_false ) ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    verify_classification_setup( ).

    verify_characteristic_setup( ).

  ENDMETHOD.