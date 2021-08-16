  METHOD get_charc_checktab_2017.

    rt_characteristic = VALUE #(
      ( charcinternalid          = '0000000010'
        characteristic           = 'CHECK_TAB_CHARC'
        charcstatus              = '01'
        charcdatatype            = 'CHAR'
        charclength              = 20
        multiplevaluesareallowed = abap_false
        charcchecktable          = cv_checktable_mara ) ).

  ENDMETHOD.