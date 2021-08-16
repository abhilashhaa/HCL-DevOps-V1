  METHOD get_characteristics_2017.

    rt_characteristic = VALUE #(
      ( charcinternalid          = '0000000001'
        characteristic           = 'CHAR_CHARC'
        charcstatus              = '01'
        charcdatatype            = 'CHAR'
        charclength              = 20
        multiplevaluesareallowed = abap_true )
      ( charcinternalid          = '0000000003'
        characteristic           = 'REF_CHARC'
        charcstatus              = '01'
        charcdatatype            = 'CHAR'
        charclength              = 20
        multiplevaluesareallowed = abap_false ) ).

  ENDMETHOD.