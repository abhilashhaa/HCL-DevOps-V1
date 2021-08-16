  METHOD CREATE_VALUE_INCORRECT_PROPS.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_test_data) = get_testdata_for_create( iv_charcdatatype = if_ngc_c=>gc_charcdatatype-char ).
    DATA(lt_valuation_data) = get_valuation_data( iv_charcdatatype = if_ngc_c=>gc_charcdatatype-char ).

    LOOP AT lt_test_data ASSIGNING FIELD-SYMBOL(<ls_test_data>).
      <ls_test_data>-charcfromdate = sy-datum.
    ENDLOOP.

    DATA(lo_clf_api_result) = setup_api_result( ).
    setup_charc_get_header( iv_number_of_expected_calling = lines( lt_test_data ) iv_charcdatatype = if_ngc_c=>gc_charcdatatype-char ).
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
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( ls_failed-objectcharcvalue )
      exp = 1
      msg = 'Failed entry was expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( ls_reported-objectcharcvalue )
      exp = 1
      msg = 'Reported entry was expected' ).

    verify_classification_setup( ).

    verify_characteristic_setup( ).

  ENDMETHOD.