  METHOD get_charc_values.

    rt_charc_value = VALUE #(
      ( charcinternalid          = cv_charc_01_id
        charcvaluepositionnumber = '1'
        charcvaluedependency     = '1'
        charcvalue               = 'VALUE01'
        validitystartdate        = cv_keydate_2017
        validityenddate          = cv_keydate_2018 )
      ( charcinternalid          = cv_charc_01_id
        charcvaluepositionnumber = '2'
        charcvaluedependency     = '1'
        charcvalue               = 'VALUE02'
        validitystartdate        = cv_keydate_2017
        validityenddate          = cv_keydate_2018 ) ).

  ENDMETHOD.