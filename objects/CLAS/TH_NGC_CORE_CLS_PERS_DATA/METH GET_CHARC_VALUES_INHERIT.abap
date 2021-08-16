  METHOD get_charc_values_inherit.

    rt_charc_value = VALUE #(
      ( charcinternalid          = cv_charc_02_id
        charcvaluepositionnumber = '1'
        charcvaluedependency     = '1'
        charcvalue               = 'VALUE_BY_INHERIT'
        validitystartdate        = cv_keydate_2017
        validityenddate          = cv_keydate_2018 ) ).

  ENDMETHOD.