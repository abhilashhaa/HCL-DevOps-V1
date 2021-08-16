  METHOD read.

    DATA:
      lt_classification_key TYPE ngct_classification_key.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*
    " single
    DATA(lt_input) = VALUE if_ngc_bil_clf=>ts_objcharcval-read-t_input(
      ( th_ngc_bil_clf_data=>gt_objectcharcval_read[ 1 ] )
    ).

    DATA(lo_clf_api_result) = setup_api_result( ).
    setup_get_assigned_values(
      EXPORTING
        iv_number_of_expected_calling = lines( lt_input )
        it_valuation_data             = th_ngc_bil_clf_data=>gt_objectcharcval_val_data_mul
        io_clf_api_result             = lo_clf_api_result
    ).
    setup_get_characteristics(
      iv_number_of_expected_calling = lines( lt_input )
      it_characteristic             = VALUE ngct_clf_characteristic_object( (
                                        charcinternalid       = lt_input[ 1 ]-charcinternalid
                                        characteristic_object = mo_ngc_characteristic ) )
      io_ngc_clf_api_result         = lo_clf_api_result ).
    LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<ls_input>).
      APPEND VALUE #( object_key       = <ls_input>-clfnobjectid
                      technical_object = <ls_input>-clfnobjecttable
                      change_number    = space
                      key_date         = sy-datum ) TO lt_classification_key.
    ENDLOOP.
    setup_api_read_multi(
      it_classification_key = lt_classification_key
      io_ngc_clf_api_result = lo_clf_api_result ).
    setup_get_internal_object_num(
      EXPORTING
        iv_number_of_expected_calling = lines( lt_input )
        it_obj_int_id                 = VALUE #(
          ( th_ngc_bil_clf_data=>gt_objectclass_read_multi_obji[ 1 ] )
        )
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~read_objcharcval(
      EXPORTING
        it_input    = lt_input
      IMPORTING
        et_result   = DATA(lt_result)
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act = COND abap_bool( WHEN lines( lt_result ) = lines( lt_input ) THEN abap_true ELSE abap_false ) ).

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).
      cl_abap_unit_assert=>assert_not_initial(
        EXPORTING
          act = <ls_result>-clfnobjectinternalid
          msg = 'Object Internal ID is not filled'
      ).
*      cl_abap_unit_assert=>assert_not_initial(
*        EXPORTING
*          act = <ls_result>-lastchangedatetime
*          msg = 'ETag is not filled'
*      ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    verify_characteristic_setup( ).

  ENDMETHOD.