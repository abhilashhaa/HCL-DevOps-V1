  METHOD create_char_value_invalid.

    DATA:
      lt_charc_value TYPE TABLE FOR CREATE i_clfnobjectcharcvaluetp.


    " Given: A class with a characteristic assigned to an object
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_complete_name
      iv_classtype = lth_test_data=>cv_class_type_300 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_classinternalid = lv_classinternalid ).

    DATA(lv_charcinternalid) = me->get_charcinternalid( lth_test_data=>cv_charc_char_multi_name ).

    lt_charc_value = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_01
        clfnobjecttable = 'MARA'
        classtype       = lth_test_data=>cv_class_type_300
        charcinternalid = lv_charcinternalid
        charcvalue      = lth_test_data=>cv_char_value_01
        charcfromdate   = sy-datum ) ).

    " When: I create a new charc value with invalid property filled
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY objectcharcvalue
        CREATE FROM lt_charc_value
          REPORTED DATA(lt_reported)
          FAILED DATA(lt_failed)
          MAPPED DATA(lt_mapped).

    " Then: Failed and reported should exist
    cl_abap_unit_assert=>assert_not_initial(
      act = lt_failed
      msg = 'One failed expected' ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lt_reported
      msg = 'One reported expected' ).

  ENDMETHOD.