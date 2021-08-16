  METHOD get_charc_funcmod_2017.

    rt_characteristic = VALUE #(
      ( charcinternalid          = cv_function_module_charcid_01
        characteristic           = cv_function_moduel_charc_01
        charcstatus              = '01'
        charcdatatype            = 'CHAR'
        charclength              = 20
        multiplevaluesareallowed = abap_false
        charccheckfunctionmodule = cv_function_module_01 ) ).

  ENDMETHOD.