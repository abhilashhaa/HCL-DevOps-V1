  METHOD read_class_by_object.

    DATA:
      lt_class TYPE TABLE FOR READ IMPORT i_clfnobjecttp\_objectclass.


    " Given: A classification in the db
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_complete_name
      iv_classtype = lth_test_data=>cv_class_type_001 ).

    DATA(lv_classinternalid_empty) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_empty_name
      iv_classtype = lth_test_data=>cv_class_type_001 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_02
      iv_classinternalid = lv_classinternalid ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_02
      iv_classinternalid = lv_classinternalid_empty ).

    lt_class = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_02
        clfnobjecttable = 'MARA' ) ).

    " When: I read this classification
    READ ENTITIES OF i_clfnobjecttp
      ENTITY object BY \_objectclass
        FROM lt_class
        RESULT DATA(lt_result)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_reported).

    " Then: No failed and reported should exist
    me->check_errors_initial(
      it_failed   = lt_failed
      it_reported = lt_reported ).

    " And: I should get the classification data
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 2
      msg = 'Two results expected' ).

  ENDMETHOD.