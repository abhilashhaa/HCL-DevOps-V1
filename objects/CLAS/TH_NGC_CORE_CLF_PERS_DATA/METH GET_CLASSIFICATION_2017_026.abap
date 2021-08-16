  METHOD GET_CLASSIFICATION_2017_026.

    rt_classification = VALUE #(
      ( clfnobjectid         = cv_object_key_01
        clfnobjecttable      = cv_object_table_mara
        classinternalid      = cv_class_01_id
        classtype            = cv_classtype_001
        clfnstatus           = '1'
        classpositionnumber  = '1' )
      ( clfnobjectid         = cv_object_key_01
        clfnobjecttable      = cv_object_table_marat
        classinternalid      = cv_class_02_id
        classtype            = cv_classtype_001
        clfnstatus           = '1'
        classpositionnumber  = '1' )
      ( clfnobjectid         = cv_object_key_02
        clfnobjectinternalid = cv_object_intkey_02
        clfnobjecttable      = cv_object_table_mara
        classinternalid      = cv_class_01_id
        classtype            = cv_classtype_300
        clfnstatus           = '1'
        classpositionnumber  = '1' ) ).

  ENDMETHOD.