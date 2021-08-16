  METHOD delete_single.

    DATA:
      lt_classification_key TYPE ngct_classification_key.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_test_data) = th_ngc_bil_clf_data=>gt_objectclass_delete_single.

    DATA(lo_clf_api_result) = setup_api_result( ).
    setup_class_remove( iv_number_of_expected_calling = lines( lt_test_data ) io_ngc_clf_api_result = lo_clf_api_result ).
    LOOP AT lt_test_data ASSIGNING FIELD-SYMBOL(<ls_test_data>).
      APPEND VALUE #( object_key       = <ls_test_data>-clfnobjectid
                      technical_object = <ls_test_data>-clfnobjecttable
                      change_number    = space
                      key_date         = sy-datum ) TO lt_classification_key.
    ENDLOOP.
    setup_api_read_multi(
      it_classification_key = lt_classification_key
      io_ngc_clf_api_result = lo_clf_api_result ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~delete_objclass(
      EXPORTING
        it_input    = lt_test_data
      IMPORTING
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

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

  ENDMETHOD.