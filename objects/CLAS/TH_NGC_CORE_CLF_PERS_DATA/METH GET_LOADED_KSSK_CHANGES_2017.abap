  METHOD get_loaded_kssk_changes_2017.

    rt_kssk_changes = VALUE #(
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_mara
        clfnobjectid        = cv_object_intkey_02
        classtype           = cv_classtype_001
        classinternalid     = cv_class_01_id
        clfnstatus          = '1'
        mafid               = 'O'
        classpositionnumber = '1'
        object_state        = if_ngc_c=>gc_object_state-loaded
        key_date            = cv_keydate_2017
        validityenddate     = '99991231' )
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_mara
        clfnobjectid        = cv_object_intkey_02
        classtype           = cv_classtype_001
        classinternalid     = cv_class_02_id
        clfnstatus          = '1'
        mafid               = 'O'
        classpositionnumber = '2'
        object_state        = if_ngc_c=>gc_object_state-created
        key_date            = cv_keydate_2017
        validityenddate     = '99991231' )
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_mara
        clfnobjectid        = cv_object_intkey_02
        classtype           = cv_classtype_001
        classinternalid     = cv_class_03_id
        clfnstatus          = '1'
        mafid               = 'O'
        classpositionnumber = '3'
        object_state        = if_ngc_c=>gc_object_state-updated
        key_date            = cv_keydate_2017
        validityenddate     = '99991231' )
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_mara
        clfnobjectid        = cv_object_intkey_02
        classtype           = cv_classtype_001
        classinternalid     = cv_class_04_id
        clfnstatus          = '1'
        mafid               = 'O'
        classpositionnumber = '4'
        object_state        = if_ngc_c=>gc_object_state-deleted
        key_date            = cv_keydate_2017
        validityenddate     = '99991231' ) ).

  ENDMETHOD.