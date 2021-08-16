  METHOD delete_class.

    DATA:
      lt_class TYPE TABLE FOR DELETE i_clfnobjectclasstp.


    " Given: A classification to delete
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_empty_name
      iv_classtype = lth_test_data=>cv_class_type_001 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_classinternalid = lv_classinternalid ).

    lt_class = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_01
        clfnobjecttable = 'MARA'
        classinternalid = lv_classinternalid ) ).

    " When: I call delete class
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY objectclass
        DELETE FROM lt_class
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

    " And: I should not find the class assignment in the db
    me->check_classification_not_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_classinternalid = lv_classinternalid ).

  ENDMETHOD.