  METHOD create_class_ref_char.

    DATA:
      lt_class    TYPE TABLE FOR CREATE i_clfnobjectclasstp,
      lt_ref_data TYPE TABLE FOR ACTION IMPORT i_clfnobjecttp~setrefdata,
      lr_data     TYPE REF TO data.

    FIELD-SYMBOLS:
      <ls_data> TYPE mara.


    " Given: A class in the database
    DATA(lv_classinternalid) = me->get_classinternalid(
      iv_class     = lth_test_data=>cv_class_ref_char_name
      iv_classtype = lth_test_data=>cv_class_type_300 ).

    me->check_classification_exist(
      iv_clfnobjectid    = lth_test_data=>cv_object_name_01
      iv_classinternalid = lv_classinternalid ).

    " And: A ref data
    CREATE DATA lr_data TYPE mara.
    ASSIGN lr_data->* TO <ls_data>.
    <ls_data> = VALUE #( matnr = lth_test_data=>cv_object_name_01 ).

    CALL TRANSFORMATION id
      SOURCE ref = lr_data
      RESULT XML DATA(lv_xml).

    lt_ref_data = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_01
        clfnobjecttable = 'MARA'
        %param          = VALUE #(
          charcreferencetable      = 'MARA'
          charcreferencedatabinary = lv_xml ) ) ).

    " When: I set ref data
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY object
        EXECUTE setrefdata FROM lt_ref_data
          FAILED DATA(lt_failed_action)
          REPORTED DATA(lt_reported_action).

    " Then: No failed and reported should exist
    me->check_errors_initial(
      it_failed   = lt_failed_action
      it_reported = lt_reported_action ).

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

    " And: I should find the reference valuation if redundant storage is enabled
    SELECT SINGLE FROM tclao
      FIELDS
        redun
      WHERE
        klart = @lth_test_data=>cv_class_type_300 AND
        obtab = 'MARA'
      INTO @DATA(lv_redun).

    IF lv_redun = abap_true.
      DATA(lv_charcinternalid) = me->get_charcinternalid( lth_test_data=>cv_charc_char_ref_name ).

      me->get_charcvalposnr(
        iv_clfnobjectid    = lth_test_data=>cv_object_name_01
        iv_classtype       = lth_test_data=>cv_class_type_300
        iv_charcinternalid = lv_charcinternalid
        iv_charcvalue      = CONV #( lth_test_data=>cv_object_name_01 ) ).
    ENDIF.

  ENDMETHOD.