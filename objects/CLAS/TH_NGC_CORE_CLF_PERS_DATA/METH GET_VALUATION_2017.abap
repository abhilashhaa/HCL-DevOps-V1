  METHOD get_valuation_2017.

    rt_valuation = VALUE #(
      ( clfnobjectid         = cv_object_key_01
        clfnobjecttable      = cv_object_table_mara
        clfnobjecttype       = 'O'
        charcvalue           = 'VALUE_01'
        charcinternalid      = '0000000001'
        charcvaluedependency = '1'
        validitystartdate    = cv_keydate_2017
        validityenddate      = cv_keydate_2018 )
      ( clfnobjectid         = cv_object_key_02
        clfnobjectinternalid = cv_object_intkey_02
        clfnobjecttable      = cv_object_table_mara
        clfnobjecttype       = 'O'
        charcvalue           = 'VALUE_01'
        charcinternalid      = '0000000001'
        charcvaluedependency = '2'
        validitystartdate    = cv_keydate_2017
        validityenddate      = cv_keydate_2018 ) ).

  ENDMETHOD.