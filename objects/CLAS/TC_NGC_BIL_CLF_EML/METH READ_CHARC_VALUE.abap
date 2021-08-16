  METHOD read_charc_value.

    DATA:
        lt_charc_value TYPE TABLE FOR READ IMPORT i_clfnobjectcharcvaluetp.

    " Given: An existing class assignment with valuation
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_complete_name
      iv_classtype = lth_test_data=>cv_class_type_001 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_02
      iv_classinternalid = lv_classinternalid ).

    DATA(lv_charcinternalid) = me->get_charcinternalid( lth_test_data=>cv_charc_char_multi_name ).

    DATA(lv_charcvaluepositionnumber) = me->get_charcvalposnr(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_02
      iv_charcinternalid = lv_charcinternalid
      iv_classtype       = lth_test_data=>cv_class_type_001
      iv_charcvalue      = lth_test_data=>cv_char_value_01 ).

    lt_charc_value = VALUE #(
      ( clfnobjectid             = lth_test_data=>cv_object_name_02
        clfnobjecttable          = 'MARA'
        classtype                = lth_test_data=>cv_class_type_001
        charcinternalid          = lv_charcinternalid
        charcvaluepositionnumber = lv_charcvaluepositionnumber ) ).

    " When: I read the charc value
    READ ENTITIES OF i_clfnobjecttp
      ENTITY objectcharcvalue
        FROM lt_charc_value
        RESULT DATA(lt_result)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_reported).

    " Then: No failed and reported should exist
    me->check_errors_initial(
      it_failed   = lt_failed
      it_reported = lt_reported ).

    " And: I should get the valuation data
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1
      msg = 'One result expected' ).

    " And: Values shuld be filled
    DATA(ls_result) = lt_result[ 1 ].

*    cl_abap_unit_assert=>assert_not_initial(
*      act = ls_result-lastchangedatetime
*      msg = 'Last changed date time should be filled' ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_result-clfnobjectid
      exp = lth_test_data=>cv_object_name_02
      msg = 'Object ID should be filled' ).

  ENDMETHOD.