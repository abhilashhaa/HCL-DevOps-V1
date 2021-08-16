  METHOD get_inob_changes_2017.

    rt_inob_changes = VALUE #(
      ( object_key           = cv_object_key_02
        technical_object     = cv_object_table_mara
        clfnobjectid         = cv_object_key_02
        clfnobjectinternalid = cv_object_intkey_02
        classtype            = cv_classtype_001
        clint                = cv_class_01_id
        statu                = '1'
        object_state         = if_ngc_c=>gc_object_state-deleted
        key_date             = cv_keydate_2017
        datuv                = cv_keydate_2017 )
      ( object_key           = cv_object_key_02
        technical_object     = cv_object_table_mara
        clfnobjectid         = cv_object_key_02
        clfnobjectinternalid = cv_object_intkey_02
        classtype            = cv_classtype_001
        clint                = cv_class_02_id
        statu                = '1'
        object_state         = if_ngc_c=>gc_object_state-created
        key_date             = cv_keydate_2017
        datuv                = cv_keydate_2017 ) ).

  ENDMETHOD.