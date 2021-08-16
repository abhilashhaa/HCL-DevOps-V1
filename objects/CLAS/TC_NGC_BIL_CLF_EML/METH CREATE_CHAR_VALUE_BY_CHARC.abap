  METHOD create_char_value_by_charc.

    DATA:
      lt_charc_value TYPE TABLE FOR CREATE i_clfnobjectcharctp\_objectcharcvalue.

    " Given: A class with a characteristic assigned to an object
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_complete_name
      iv_classtype = lth_test_data=>cv_class_type_300 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_classinternalid = lv_classinternalid ).

    DATA(lv_charcinternalid) = me->get_charcinternalid( lth_test_data=>cv_charc_char_multi_name ).

    me->check_char_val_not_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_charcinternalid = lv_charcinternalid
      iv_classtype       = lth_test_data=>cv_class_type_300
      iv_charcvalue      = lth_test_data=>cv_char_value_02 ).

    lt_charc_value = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_01
        clfnobjecttable = 'MARA'
        classtype       = lth_test_data=>cv_class_type_300
        charcinternalid = lv_charcinternalid
        %target         = VALUE #(
          ( charcvalue      = lth_test_data=>cv_char_value_02 ) ) ) ).

    " When: I create a new charc value
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY objectcharc
        CREATE BY \_objectcharcvalue FROM lt_charc_value
          REPORTED DATA(lt_reported)
          FAILED DATA(lt_failed)
          MAPPED DATA(lt_mapped).

    " Then: No failed and reported should exist
    me->check_errors_initial(
      it_failed   = lt_failed
      it_reported = lt_reported ).

    " And: Mapping should be filled
    cl_abap_unit_assert=>assert_not_initial(
      act = lt_mapped
      msg = 'Mapping should be filled' ).

    " When: I commit the changes
    COMMIT ENTITIES RESPONSE OF i_clfnobjecttp
      REPORTED DATA(lt_reported_late)
      FAILED DATA(lt_failed_late).

    " Then: No failed and reported should exist
    me->check_errors_initial(
      it_failed   = lt_failed_late
      it_reported = lt_reported_late ).

    " And: I should find the charc value in the db
    me->get_charcvalposnr(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_charcinternalid = lv_charcinternalid
      iv_classtype       = lth_test_data=>cv_class_type_300
      iv_charcvalue      = lth_test_data=>cv_char_value_02 ).

  ENDMETHOD.