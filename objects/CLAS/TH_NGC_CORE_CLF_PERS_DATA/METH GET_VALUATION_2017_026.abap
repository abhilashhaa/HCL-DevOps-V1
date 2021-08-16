  METHOD GET_VALUATION_2017_026.

    rt_valuation = VALUE #(
      ( clfnobjectid         = cv_object_key_01
        clfnobjecttable      = cv_object_table_mara
        classtype            = cv_classtype_026
        clfnobjecttype       = 'O'
        charcvalue           = 'VALUE_01'
        charcinternalid      = '0000000001'
        charcvaluedependency = ''
        validitystartdate    = cv_keydate_2017
        validityenddate      = cv_keydate_2018 )

      ( clfnobjectid         = cv_object_key_01
        clfnobjectinternalid = cv_object_intkey_02
        clfnobjecttable      = cv_object_table_marat
        classtype            = cv_classtype_026
        charcvaluepositionnumber  = '1'
        clfnobjecttype            = 'O'
        charcfromnumericvalue     = 100
        charcfromnumericvalueunit = 'KG'
        charcvaluedependency      = '1'
        validitystartdate    = cv_keydate_2017
        validityenddate      = cv_keydate_2018 ) ).

  ENDMETHOD.