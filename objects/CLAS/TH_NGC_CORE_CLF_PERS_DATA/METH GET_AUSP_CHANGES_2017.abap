  METHOD get_ausp_changes_2017.

    rt_ausp_changes = VALUE #(
      ( object_key                = cv_object_key_01
        technical_object          = cv_object_table_mara
        object_state              = if_ngc_c=>gc_object_state-created
        clfnobjectid              = cv_object_key_01
        charcinternalid           = '0000000001'
        charcvaluepositionnumber  = '1'
        clfnobjecttype            = 'O'
        classtype                 = cv_classtype_001
        charcvalue                = 'VALUE01'
        charcvaluedependency      = '1'
        key_date                  = cv_keydate_2017
        validitystartdate         = cv_keydate_2017
        validityenddate           = cv_keydate_2018 )
      ( object_key                = cv_object_key_02
        technical_object          = cv_object_table_mara
        object_state              = if_ngc_c=>gc_object_state-deleted
        clfnobjectid              = cv_object_intkey_02
        charcinternalid           = '0000000002'
        charcvaluepositionnumber  = '1'
        clfnobjecttype            = 'O'
        classtype                 = cv_classtype_001
        charcfromnumericvalue     = 100
        charcfromnumericvalueunit = 'KG'
        charcvaluedependency      = '1'
        key_date                  = cv_keydate_2017
        validitystartdate         = cv_keydate_2017
        validityenddate           = cv_keydate_2018 ) ).

  ENDMETHOD.