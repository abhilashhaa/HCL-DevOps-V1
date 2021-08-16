  METHOD create_op_get_clfn_failure.

**--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lo_clf_api_result) = setup_api_result(
      it_message = VALUE #(
        ( msgty = 'E' ) ) ).
    setup_api_read(
      it_classificaton_object = VALUE #( )
      io_ngc_clf_api_result   = lo_clf_api_result ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~create_objclass(
      EXPORTING
        it_input    = VALUE #( ( ) )
      IMPORTING
        es_mapped   = DATA(ls_mapped)
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

    cl_abap_unit_assert=>assert_initial(
      act = ls_mapped
      msg = 'No mapped entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_classification
      msg = 'Classification object should not be exist' ).

  ENDMETHOD.