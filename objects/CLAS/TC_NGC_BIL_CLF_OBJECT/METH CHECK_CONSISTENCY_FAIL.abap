  METHOD check_consistency_fail.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lo_clf_api_result) = setup_api_result(
      it_message = VALUE #( ( msgty = 'E' ) ) ).
    setup_api_validate( io_ngc_clf_api_result = lo_clf_api_result ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~exec_obj_checkconsistency(
      EXPORTING
        it_input    = VALUE #( ( ) )
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

    verify_api_setup( ).

  ENDMETHOD.