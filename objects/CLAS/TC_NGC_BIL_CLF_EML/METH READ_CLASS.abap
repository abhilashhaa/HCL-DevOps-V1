  METHOD read_class.

    DATA:
      lt_class TYPE TABLE FOR READ IMPORT i_clfnobjectclasstp.

    " Given: A classification in the db
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_complete_name
      iv_classtype = lth_test_data=>cv_class_type_001 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_02
      iv_classinternalid = lv_classinternalid ).

    lt_class = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_02
        clfnobjecttable = 'MARA'
        classinternalid = lv_classinternalid  ) ).

    " When: I read this classification
    READ ENTITIES OF i_clfnobjecttp
      ENTITY objectclass
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
      exp = 1
      msg = 'One result expected' ).

    " And: Last changed date time should be filled
    DATA(ls_result) = lt_result[ 1 ].

*    cl_abap_unit_assert=>assert_not_initial(
*      act = ls_result-lastchangedatetime
*      msg = 'Last changed date time should be filled' ).

  ENDMETHOD.