  METHOD get_mara_for_checktable.

    rt_mara = VALUE #(
      ( matnr = 'MAT_01'
        mtart = 'FERT' )
      ( matnr = 'MAT_02'
        mtart = 'HALB' ) ).

  ENDMETHOD.