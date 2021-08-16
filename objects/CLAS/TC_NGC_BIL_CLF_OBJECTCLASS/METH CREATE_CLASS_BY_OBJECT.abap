  METHOD create_class_by_object.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*
    DATA:
      lt_test_data_temp TYPE if_ngc_bil_clf=>ts_obj-create_by-_objectclass-t_input.

    DATA(lt_test_data) = th_ngc_bil_clf_data=>gt_objectcl_create_cls_by_obj.

    DATA(lo_clf_api_result) = setup_api_result( ).
    lt_test_data_temp = lt_test_data.
    SORT lt_test_data_temp ASCENDING BY clfnobjectid clfnobjecttable.
    DELETE ADJACENT DUPLICATES FROM lt_test_data_temp COMPARING clfnobjectid clfnobjecttable.
    DATA(lv_lines_mapped) = REDUCE i( INIT x = 0 FOR ls_test_data IN lt_test_data NEXT x = x + lines( ls_test_data-%target ) ).
    DATA(lv_lines) = lines( lt_test_data_temp ).
    setup_class_assign(
      iv_number_of_expected_calling = lv_lines
      io_ngc_clf_api_result         = lo_clf_api_result
    ).
    setup_api_read(
      is_classification_key = VALUE #( object_key       = lt_test_data[ 1 ]-clfnobjectid
                                       technical_object = lt_test_data[ 1 ]-clfnobjecttable
                                       change_number    = space
                                       key_date         = sy-datum )
      io_ngc_clf_api_result = lo_clf_api_result ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~create_obj_objclass(
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
      exp = lv_lines_mapped ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    verify_classification_setup( ).

  ENDMETHOD.