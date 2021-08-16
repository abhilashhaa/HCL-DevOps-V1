  METHOD get_charc_values_inherit_db.

    rt_class_charc_value = VALUE #(
      ( clfnobjectid             = cv_class_01_id
        charcinternalid          = cv_charc_02_id
        charcvaluepositionnumber = '1'
        clfnobjecttype           = 'K'
        classtype                = cv_classtype_001
        charcvalue               = 'VALUE_OVERWRITE'
        validitystartdate        = cv_keydate_2017
        validityenddate          = cv_keydate_2018 ) ).

  ENDMETHOD.