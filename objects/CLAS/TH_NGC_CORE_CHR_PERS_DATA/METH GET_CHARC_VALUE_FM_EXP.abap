  METHOD get_charc_value_fm_exp.

    rt_charc_value = VALUE #(
      ( charcinternalid       = cv_function_module_charcid_01
        charcvalue            = cv_value_01
        charcvaluedependency  = '1'
        charcvaluedescription = 'Phrase: Descr 01'
        key_date              = cv_keydate_2017 )
      ( charcinternalid       = cv_function_module_charcid_01
        charcvalue            = cv_value_01
        charcvaluedependency  = '1'
        charcvaluedescription = 'Descr 02'
        key_date              = cv_keydate_2017 ) ).

  ENDMETHOD.