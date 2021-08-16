  METHOD set_ref_data_call_transf_fail.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    setup_set_reference_data( iv_number_of_expected_calling = 0 ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~exec_obj_setrefdata(
      EXPORTING
        it_input    = VALUE #( ( %param-charcreferencetable = 'STRING' ) )
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