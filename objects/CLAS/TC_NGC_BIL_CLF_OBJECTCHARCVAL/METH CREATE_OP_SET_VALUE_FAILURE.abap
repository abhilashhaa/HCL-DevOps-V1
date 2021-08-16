  METHOD create_op_set_value_failure.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lv_charcdatatype) = if_ngc_c=>gc_charcdatatype-char.

    DATA(lt_test_data) = get_testdata_for_create( iv_charcdatatype = lv_charcdatatype ).

    DATA(lo_clf_api_result) = setup_api_result(
      it_message = VALUE #(
        ( object_key       = lt_test_data[ 1 ]-clfnobjectid
          technical_object = lt_test_data[ 1 ]-clfnobjecttable
          msgty            = 'E' ) ) ).
    setup_set_value(
      EXPORTING
        iv_charcdatatype              = lv_charcdatatype
        iv_number_of_expected_calling = lines( lt_test_data )
        io_clf_api_result             = lo_clf_api_result
    ).
    lo_clf_api_result = setup_api_result( ).
    setup_charc_get_header( iv_number_of_expected_calling = lines( lt_test_data ) iv_charcdatatype = lv_charcdatatype ).
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

    cl_abap_unit_assert=>assert_initial(
      act = ls_mapped
      msg = 'No mapped entry was expected' ).

    cl_abap_unit_assert=>assert_not_initial(
      act = ls_failed
      msg = 'Failed entry was expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( ls_failed-objectcharcvalue )
      exp = 1 ).

    DATA(ls_failed_charcvalue) = ls_failed-objectcharcvalue[ 1 ].
    DATA(ls_failed_charcvalue_exp) = VALUE if_ngc_bil_clf=>ts_objcharcval-response-s_failed(
      %cid            = 'CID1'
      clfnobjectid    = 'OBJ_1'
      clfnobjecttable = 'TBL_1'
      classtype       = 'AU1'
      charcinternalid = '1' ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_failed_charcvalue
      exp = ls_failed_charcvalue_exp ).

    cl_abap_unit_assert=>assert_not_initial(
      act = ls_reported
      msg = 'Reported entry was expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( ls_reported-objectcharcvalue )
      exp = 1 ).

    DATA(ls_reported_charcvalue) = ls_reported-objectcharcvalue[ 1 ].
    DATA(ls_reported_charcvalue_exp) = VALUE if_ngc_bil_clf=>ts_objcharcval-response-s_reported(
      %cid            = 'CID1'
      clfnobjectid    = 'OBJ_1'
      clfnobjecttable = 'TBL_1'
      classtype       = 'AU1'
      charcinternalid = '1' ).
    CLEAR ls_reported_charcvalue-%msg.

    cl_abap_unit_assert=>assert_equals(
      act = ls_reported_charcvalue
      exp = ls_reported_charcvalue_exp ).

    cl_abap_unit_assert=>assert_initial( ls_reported_charcvalue-charcvaluepositionnumber ).

    verify_classification_setup( ).

    verify_characteristic_setup( ).

  ENDMETHOD.