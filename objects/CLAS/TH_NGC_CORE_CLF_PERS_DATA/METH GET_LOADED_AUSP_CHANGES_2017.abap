  METHOD get_loaded_ausp_changes_2017.

    rt_ausp_changes = VALUE #(
      ( object_key                = cv_object_key_01
        technical_object          = cv_object_table_mara
        object_state              = if_ngc_c=>gc_object_state-loaded
        clfnobjectid              = cv_object_intkey_02
        charcinternalid           = '0000000001'
        charcvaluepositionnumber  = '1'
        clfnobjecttype            = 'O'
        classtype                 = cv_classtype_001
        charcvalue                = 'VALUE01'
        charcvaluedependency      = '1'
        key_date                  = cv_keydate_2017
        validitystartdate         = cv_keydate_2017
        validityenddate           = cv_keydate_2018 )
      ( object_key                = cv_object_key_01
        technical_object          = cv_object_table_mara
        object_state              = if_ngc_c=>gc_object_state-created
        clfnobjectid              = cv_object_intkey_02
        charcinternalid           = '0000000001'
        charcvaluepositionnumber  = '2'
        clfnobjecttype            = 'O'
        classtype                 = cv_classtype_001
        charcvalue                = 'VALUE02'
        charcvaluedependency      = '1'
        key_date                  = cv_keydate_2017
        validitystartdate         = cv_keydate_2017
        validityenddate           = cv_keydate_2018 )
      ( object_key                = cv_object_key_01
        technical_object          = cv_object_table_mara
        object_state              = if_ngc_c=>gc_object_state-updated
        clfnobjectid              = cv_object_intkey_02
        charcinternalid           = '0000000001'
        charcvaluepositionnumber  = '3'
        clfnobjecttype            = 'O'
        classtype                 = cv_classtype_001
        charcvalue                = 'VALUE03'
        charcvaluedependency      = '1'
        key_date                  = cv_keydate_2017
        validitystartdate         = cv_keydate_2017
        validityenddate           = cv_keydate_2018 )
      ( object_key                = cv_object_key_01
        technical_object          = cv_object_table_mara
        object_state              = if_ngc_c=>gc_object_state-deleted
        clfnobjectid              = cv_object_intkey_02
        charcinternalid           = '0000000001'
        charcvaluepositionnumber  = '4'
        clfnobjecttype            = 'O'
        classtype                 = cv_classtype_001
        charcvalue                = 'VALUE04'
        charcvaluedependency      = '1'
        key_date                  = cv_keydate_2017
        validitystartdate         = cv_keydate_2017
        validityenddate           = cv_keydate_2018 ) ).

  ENDMETHOD.