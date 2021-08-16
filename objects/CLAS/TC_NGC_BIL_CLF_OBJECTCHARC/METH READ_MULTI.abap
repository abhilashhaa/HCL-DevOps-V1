  METHOD read_multi.

    DATA:
      lt_classification_key TYPE ngct_classification_key.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_input) = th_ngc_bil_clf_data=>gt_objectcharc_read_multi.

    DATA(lo_clf_api_result) = setup_api_result( ).
    setup_get_characteristics(
      iv_number_of_expected_calling = lines( lt_input )
      it_characteristic             = VALUE ngct_clf_characteristic_object(
        ( charcinternalid       = lt_input[ 1 ]-charcinternalid
          classtype             = lt_input[ 1 ]-classtype
          characteristic_object = mo_ngc_characteristic )
        ( charcinternalid       = lt_input[ 2 ]-charcinternalid
          classtype             = lt_input[ 2 ]-classtype
          characteristic_object = mo_ngc_characteristic )
      )
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
          ( th_ngc_bil_clf_data=>gt_objectclass_read_multi_obji[ 3 ] ) ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~read_objcharc(
      EXPORTING
        it_input    = lt_input
      IMPORTING
        et_result   = DATA(lt_result)
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lines( lt_result )
        exp = lines( lt_input ) ).

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