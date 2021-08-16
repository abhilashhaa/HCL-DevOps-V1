  METHOD get_makt_for_checktable.

    rt_makt = VALUE #(
      ( matnr = 'MAT_01'
        spras = 'EN'
        maktx = 'Test description 01' )
      ( matnr = 'MAT_01'
        spras = 'DE'
        maktx = 'Test DE description 01' )
      ( matnr = 'MAT_02'
        spras = 'EN'
        maktx = 'Test description 02' )
      ( matnr = 'MAT_02'
        spras = 'DE'
        maktx = 'Test DE description 02' ) ).

  ENDMETHOD.