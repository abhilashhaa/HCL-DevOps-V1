  METHOD get_fm_charc_01_values.

    rt_value = VALUE #(
      ( charcinternalid       = cv_function_module_charcid_01
        charcvalue            = cv_value_01
        charcvaluedescription = 'Descr 01'
        keydate               = cv_keydate_2017
        phrase                = cv_phrase_01 )
      ( charcinternalid       = cv_function_module_charcid_01
        charcvalue            = cv_value_02
        charcvaluedescription = 'Descr 02'
        keydate               = cv_keydate_2017 ) ).

  ENDMETHOD.