  METHOD delete_char_value.

    DATA:
      lt_charc_value TYPE TABLE FOR DELETE i_clfnobjectcharcvaluetp.

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
      iv_charcvalue      = lth_test_data=>cv_char_value_01 ).

    lt_charc_value = VALUE #(
      ( clfnobjectid             = lth_test_data=>cv_object_name_01
        clfnobjecttable          = 'MARA'
        classtype                = lth_test_data=>cv_class_type_001
        charcinternalid          = lv_charcinternalid
        charcvaluepositionnumber = lv_charcvaluepositionnumber ) ).

    " When: I delete the charc value
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY objectcharcvalue
        DELETE FROM lt_charc_value
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
    me->check_charc_val_not_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_charcinternalid = lv_charcinternalid
      iv_classtype       = lth_test_data=>cv_class_type_001
      iv_charcvalposnr   = lv_charcvaluepositionnumber ).

  ENDMETHOD.