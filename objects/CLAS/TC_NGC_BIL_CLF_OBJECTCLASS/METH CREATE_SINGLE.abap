  METHOD create_single.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_test_data) = th_ngc_bil_clf_data=>gt_objectclass_create_single.

    DATA(lo_clf_api_result) = setup_api_result( ).
    setup_class_assign( iv_number_of_expected_calling = lines( lt_test_data ) io_ngc_clf_api_result = lo_clf_api_result ).
    setup_api_read(
      is_classification_key = VALUE #( object_key       = lt_test_data[ 1 ]-clfnobjectid
                                       technical_object = lt_test_data[ 1 ]-clfnobjecttable
                                       change_number    = space
                                       key_date         = sy-datum )
      io_ngc_clf_api_result = lo_clf_api_result ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~create_objclass(
      EXPORTING
        it_input    = lt_test_data
      IMPORTING
        es_mapped   = DATA(ls_mapped)
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( ls_mapped-objectclass )
      exp = 1 ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    " Success message
    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    verify_classification_setup( ).

  ENDMETHOD.