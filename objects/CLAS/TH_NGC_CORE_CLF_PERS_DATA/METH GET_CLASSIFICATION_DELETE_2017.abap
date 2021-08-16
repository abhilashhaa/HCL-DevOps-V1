  METHOD get_classification_delete_2017.

    rt_classification_upd = VALUE #(
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_mara
        key_date            = cv_keydate_2017
        classification_data = VALUE #(
          ( classinternalid     = cv_class_01_id
            clfnstatus          = '1'
            classpositionnumber = '1'
            object_state        = if_ngc_c=>gc_object_state-deleted )
          ( classinternalid     = cv_class_03_id
            clfnstatus          = '1'
            classpositionnumber = '3'
            object_state        = if_ngc_c=>gc_object_state-deleted ) )
        valuation_data      = VALUE #(
          ( clfnobjectid             = cv_object_key_01
            charcinternalid          = '000000001'
            charcvaluepositionnumber = '1'
            clfnobjecttype           = 'O'
            classtype                = cv_classtype_001
            charcvalue               = 'VALUE01'
            charcvaluedependency     = '1'
            validitystartdate        = cv_keydate_2017
            validityenddate          = cv_keydate_2018
            object_state             = if_ngc_c=>gc_object_state-deleted )
          ( clfnobjectid             = cv_object_key_01
            charcinternalid          = '000000001'
            charcvaluepositionnumber = '3'
            clfnobjecttype           = 'O'
            classtype                = cv_classtype_001
            charcvalue               = 'VALUE03'
            charcvaluedependency     = '1'
            validitystartdate        = cv_keydate_2017
            validityenddate          = cv_keydate_2018
            object_state             = if_ngc_c=>gc_object_state-deleted ) ) ) ).

  ENDMETHOD.