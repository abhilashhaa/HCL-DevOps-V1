  METHOD get_kssk_changes_2017.

    rt_kssk_changes = VALUE #(
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_mara
        clfnobjectid        = cv_object_key_01
        classtype           = cv_classtype_001
        classinternalid     = cv_class_01_id
        clfnstatus          = '1'
        mafid               = 'O'
        classpositionnumber = '1'
        object_state        = if_ngc_c=>gc_object_state-created
        key_date            = cv_keydate_2017
        validitystartdate   = cv_keydate_2017
        validityenddate     = cv_keydate_2018 )
      ( object_key          = cv_object_key_02
        technical_object    = cv_object_table_mara
        clfnobjectid        = cv_object_intkey_02
        classtype           = cv_classtype_300
        classinternalid     = cv_class_02_id
        clfnstatus          = '1'
        mafid               = 'O'
        classpositionnumber = '1'
        object_state        = if_ngc_c=>gc_object_state-deleted
        key_date            = cv_keydate_2017
        validitystartdate   = cv_keydate_2017
        validityenddate     = cv_keydate_2018 )
      ( object_key          = cv_object_key_02
        technical_object    = cv_object_table_mara
        clfnobjectid        = cv_object_intkey_02
        classtype           = cv_classtype_300
        classinternalid     = cv_class_02_id
        clfnstatus          = '1'
        mafid               = 'O'
        classpositionnumber = '1'
        object_state        = if_ngc_c=>gc_object_state-updated
        key_date            = cv_keydate_2017
        validitystartdate   = cv_keydate_2017
        validityenddate     = cv_keydate_2018 ) ).

  ENDMETHOD.