  METHOD finalize.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lo_clf_api_result) = setup_api_result( ).
    setup_api_update( io_ngc_clf_api_result = lo_clf_api_result ).

    get_responses(
      IMPORTING
        es_reported_late = DATA(ls_reported_late)
        es_failed_late   = DATA(ls_failed_late) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf_transactional~finalize(
      IMPORTING
        es_failed   = ls_failed_late
        es_reported = ls_reported_late ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed_late
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported_late
      msg = 'No reported entry was expected' ).

    verify_api_setup( ).

  ENDMETHOD.