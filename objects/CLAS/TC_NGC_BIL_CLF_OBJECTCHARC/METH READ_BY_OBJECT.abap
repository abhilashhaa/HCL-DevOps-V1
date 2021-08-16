  METHOD read_by_object.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*
    DATA:
      lt_classification_key TYPE ngct_classification_key.

    DATA(lt_input) = th_ngc_bil_clf_data=>gt_objectcharc_read_by_object.
    DATA(lt_characteristic) = VALUE ngct_clf_characteristic_object(
      ( charcinternalid       = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[ 1 ]-charcinternalid
        characteristic_object = mo_ngc_characteristic
        classtype             = 'AU1' )
      ( charcinternalid       = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[ 2 ]-charcinternalid
        characteristic_object = mo_ngc_characteristic
        classtype             = 'AU2' )
      ( charcinternalid       = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[ 3 ]-charcinternalid
        characteristic_object = mo_ngc_characteristic
        classtype             = 'AU2' )
    ).
    DATA(lo_clf_api_result) = setup_api_result( ).
    DATA(lv_lines) = lines( lt_characteristic ).
    setup_get_characteristics(
      iv_number_of_expected_calling = lv_lines
      it_characteristic             = lt_characteristic
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

    mo_cut->if_ngc_bil_clf~read_obj_objcharc(
      EXPORTING
        it_input    = lt_input
      IMPORTING
        et_result   = DATA(lt_result)
        et_link     = DATA(lt_link)
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act = COND abap_bool( WHEN lines( lt_result ) = lv_lines THEN abap_true ELSE abap_false ) ).

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