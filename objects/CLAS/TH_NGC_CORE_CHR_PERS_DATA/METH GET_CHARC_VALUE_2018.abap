  METHOD get_charc_value_2018.

    rt_charc_value = VALUE #(
      ( charcinternalid          = '0000000002'
        charcvaluepositionnumber = 1
        charcvaluedependency     = 4
        charcfromnumericvalue    = 100
        charctonumericvalue      = 400
        isdefaultvalue           = abap_true )
      ( charcinternalid          = '0000000002'
        charcvaluepositionnumber = 2
        charcvaluedependency     = 6
        charcfromnumericvalue    = 600
        isdefaultvalue           = abap_false ) ).

  ENDMETHOD.