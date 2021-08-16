  METHOD get_charc_value_2017.

    rt_charc_value = VALUE #(
      ( charcinternalid          = '0000000001'
        charcvaluepositionnumber = 1
        charcvaluedependency     = 1
        charcvalue               = 'VALUE_01'
        isdefaultvalue           = abap_true )
      ( charcinternalid          = '0000000001'
        charcvaluepositionnumber = 2
        charcvaluedependency     = 1
        charcvalue               = 'VALUE_02'
        isdefaultvalue           = abap_true ) ).

  ENDMETHOD.