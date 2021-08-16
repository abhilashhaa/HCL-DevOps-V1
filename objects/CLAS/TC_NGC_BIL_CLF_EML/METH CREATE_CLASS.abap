  METHOD create_class.

    DATA:
      lt_class TYPE TABLE FOR CREATE i_clfnobjectclasstp.


    " Given: A class in the database
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_empty_name
      iv_classtype = lth_test_data=>cv_class_type_300 ).

    me->check_classification_not_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_classinternalid = lv_classinternalid ).

    lt_class = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_01
        clfnobjecttable = 'MARA'
        classtype       = lth_test_data=>cv_class_type_300
        classinternalid = lv_classinternalid ) ).

    " When: I call create class
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY objectclass
        CREATE FROM lt_class
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

    " And: I should find the class assignment in the db
    SELECT SINGLE @abap_true FROM i_clfnobjectclass
      INTO @DATA(lv_exists_after)
      WHERE
        clfnobjectid    = @lth_test_data=>cv_object_name_01 AND
        clfnobjecttable = 'MARA' AND
        classinternalid = @lv_classinternalid.

    cl_abap_unit_assert=>assert_true(
      act = lv_exists_after
      msg = 'Class assignment should exist' ).

  ENDMETHOD.