  METHOD get_characteristics_2018.

    rt_characteristic = VALUE #(
      ( charcinternalid          = '0000000002'
        characteristic           = 'NUM_CHARC'
        charcstatus              = '01'
        charcdatatype            = 'NUM'
        charclength              = 6
        multiplevaluesareallowed = abap_false
        charcdecimals            = 4
        valueintervalisallowed   = abap_true ) ).

  ENDMETHOD.