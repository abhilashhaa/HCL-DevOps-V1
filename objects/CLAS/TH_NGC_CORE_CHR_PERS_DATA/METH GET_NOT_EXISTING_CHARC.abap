  METHOD get_not_existing_charc.

    rt_characteristic = VALUE #(
      ( charcinternalid          = '1000000000'
        characteristic           = 'NOT_EXISTING_CHARC'
        charcstatus              = '01'
        charcdatatype            = 'CHAR'
        charclength              = 20
        multiplevaluesareallowed = abap_true ) ).

  ENDMETHOD.