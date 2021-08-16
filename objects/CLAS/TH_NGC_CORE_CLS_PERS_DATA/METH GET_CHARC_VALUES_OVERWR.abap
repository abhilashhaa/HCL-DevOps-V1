  METHOD get_charc_values_overwr.

    rt_charc_value = VALUE #(
      ( charcinternalid            = cv_charc_02_id
        overwrittencharcinternalid = cv_charc_overwritten_id
        charcvaluepositionnumber   = '1'
        charcvaluedependency       = '1'
        charcvalue                 = 'VALUE_BY_OVERWRITE'
        validitystartdate          = cv_keydate_2017
        validityenddate            = cv_keydate_2018 ) ).

  ENDMETHOD.