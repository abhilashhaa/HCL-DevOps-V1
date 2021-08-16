  METHOD get_charc_ref.

    rt_charc_ref = VALUE #(
      ( charcinternalid          = cv_charc_02_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' )
      ( charcinternalid          = cv_charc_02_id
        charcreferencetable      = 'MCHA'
        charcreferencetablefield = 'MATNR' ) ).

  ENDMETHOD.