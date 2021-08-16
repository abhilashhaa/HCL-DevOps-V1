  METHOD setup.

    DATA:
      lt_cabn TYPE TABLE OF cabn,
      lt_cawn TYPE TABLE OF cawn.

    environment->clear_doubles( ).

    lt_cabn = VALUE #(
      ( mandt = sy-mandt
        atinn = '0000000001'
        adzhl = '0000'
        atfor = 'NUM'
        msehi = 'A'
      )
      ( mandt = sy-mandt
        atinn = '0000000002'
        adzhl = '0000'
        atfor = 'CURR'
        msehi = 'EUR'
      )
      ( mandt = sy-mandt
        atinn = '0000000003'
        adzhl = '0000'
        atfor = 'DATE'
        msehi = 'B'
      )
      ( mandt = sy-mandt
        atinn = '0000000004'
        adzhl = '0000'
        atfor = 'TIME'
        msehi = 'C'
      )
      ( mandt = sy-mandt
        atinn = '0000000005'
        adzhl = '0000'
        atfor = 'NUM'
        msehi = 'A'
      )
      ( mandt = sy-mandt
        atinn = '0000000006'
        adzhl = '0000'
        atfor = 'CURR'
        msehi = 'EUR'
      )
      ( mandt = sy-mandt
        atinn = '0000000007'
        adzhl = '0000'
        atfor = 'DATE'
        msehi = 'B'
      )
      ( mandt = sy-mandt
        atinn = '0000000008'
        adzhl = '0000'
        atfor = 'TIME'
        msehi = 'C'
      )
      ( mandt = sy-mandt
        atinn = '0000000009'
        adzhl = '0000'
        atfor = 'NUM'
        msehi = 'D'
      )
    ).

    DATA(lo_cabn) = cl_cds_test_data=>create( lt_cabn ).
    environment->get_double( 'CABN' )->insert( lo_cabn  ).

    lt_cawn = VALUE #(
      ( mandt     = sy-mandt
        atinn     = '0000000001'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 1
        atflb     = 99
        dec_from  = 1
        dec_to    = 99
      )
      ( mandt     = sy-mandt
        atinn     = '0000000002'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 100
        atflb     = 10000
        curr_from = 100
        curr_to   = 10000
        currency  = 'EUR'
      )
      ( mandt     = sy-mandt
        atinn     = '0000000003'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 20190101
        atflb     = 20191231
        date_from = '20190101'
        date_to   = '20191231'
      )
      ( mandt     = sy-mandt
        atinn     = '0000000004'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 112233
        atflb     = 223344
        time_from = '112233'
        time_to   = '223344'
      )
      ( mandt     = sy-mandt
        atinn     = '0000000005'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 1
        atflb     = 99
      )
      ( mandt     = sy-mandt
        atinn     = '0000000006'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 100
        atflb     = 10000
      )
      ( mandt     = sy-mandt
        atinn     = '0000000007'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 20190101
        atflb     = 20191231
      )
      ( mandt     = sy-mandt
        atinn     = '0000000008'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 112233
        atflb     = 223344
      )
      ( mandt     = sy-mandt
        atinn     = '0000000009'
        atzhl     = '0001'
        adzhl     = '0000'
        atflv     = 0
        atflb     = 0
      )
    ).

    DATA(lo_cawn) = cl_cds_test_data=>create( lt_cawn ).
    environment->get_double( 'CAWN' )->insert( lo_cawn  ).

  ENDMETHOD.