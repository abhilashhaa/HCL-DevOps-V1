  METHOD update_char_value.

    DATA:
      lt_charc_value TYPE TABLE FOR UPDATE i_clfnobjectcharcvaluetp.

    " Given: An existing class assignment with valuation
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_complete_name
      iv_classtype = lth_test_data=>cv_class_type_001 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_classinternalid = lv_classinternalid ).

    DATA(lv_charcinternalid) = me->get_charcinternalid( lth_test_data=>cv_charc_char_multi_name ).

    DATA(lv_charcvaluepositionnumber) = me->get_charcvalposnr(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_charcinternalid = lv_charcinternalid
      iv_classtype       = lth_test_data=>cv_class_type_001
      iv_charcvalue      = lth_test_data=>cv_char_value_02 ).

    lt_charc_value = VALUE #(
      ( clfnobjectid             = lth_test_data=>cv_object_name_01
        clfnobjecttable          = 'MARA'
        classtype                = lth_test_data=>cv_class_type_001
        charcinternalid          = lv_charcinternalid
        charcvaluepositionnumber = lv_charcvaluepositionnumber
        charcvalue               = lth_test_data=>cv_char_value_03
        %control                 = VALUE #(
          charcvalue = '01' ) ) ).

    " When: I delete the charc value
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY objectcharcvalue
        UPDATE FROM lt_charc_value
          REPORTED DATA(lt_reported)
          FAILED DATA(lt_failed).

    " Then: No failed and reported should exist
    me->check_errors_initial(
      it_failed   = lt_failed
      it_reported = lt_reported ).

    " When: I commit the changes
    COMMIT ENTITIES RESPONSE OF i_clfnobjecttp
      REPORTED DATA(lt_reported_late)
      FAILED DATA(lt_failed_late).

    " Then: No failed and reported should exist
    me->check_errors_initial(
      it_failed   = lt_failed_late
      it_reported = lt_reported_late ).

    " And: I should not find the charc value in the db
    SELECT SINGLE charcvalue FROM i_clfnobjectcharcvalue
      INTO @DATA(lv_charcvalue)
      WHERE
        clfnobjectid             = @lth_test_data=>cv_object_name_01 AND
        clfnobjecttable          = 'MARA' AND
        charcinternalid          = @lv_charcinternalid AND
        classtype                = @lth_test_data=>cv_class_type_001 AND
        charcvaluepositionnumber = @lv_charcvaluepositionnumber.

    cl_abap_unit_assert=>assert_equals(
      act = lv_charcvalue
      exp = lth_test_data=>cv_char_value_03
      msg = 'Charc value should be updated' ).

  ENDMETHOD.