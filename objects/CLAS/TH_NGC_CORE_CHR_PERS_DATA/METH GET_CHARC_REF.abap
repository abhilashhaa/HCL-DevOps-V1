  METHOD get_charc_ref.

    rt_charc_ref = VALUE #(
      ( charcinternalid          = '0000000003'
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' )
      ( charcinternalid          = '0000000003'
        charcreferencetable      = 'MCHA'
        charcreferencetablefield = 'MATNR' ) ).

  ENDMETHOD.