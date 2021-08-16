  METHOD check.

    DATA:
      lt_p_clfnsdmcawn_exp TYPE TABLE OF p_clfnsdmcawn.

    environment->get_access_control_double( )->disable_access_control( ).

    lt_p_clfnsdmcawn_exp = VALUE #(
      ( sdm_status    = '02'
        atinn         = '0000000001'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 1
        atflb         = 99
        chr_data_type = 'NUM'
        msehi         = 'A'
      )
      ( sdm_status    = '02'
        atinn         = '0000000002'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 100
        atflb         = 10000
        chr_data_type = 'CURR'
        msehi         = 'EUR'
      )
      ( sdm_status    = '02'
        atinn         = '0000000003'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 20190101
        atflb         = 20191231
        chr_data_type = 'DATE'
        msehi         = 'B'
      )
      ( sdm_status    = '02'
        atinn         = '0000000004'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 112233
        atflb         = 223344
        chr_data_type = 'TIME'
        msehi         = 'C'
      )
      ( sdm_status    = '01'
        atinn         = '0000000005'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 1
        atflb         = 99
        chr_data_type = 'NUM'
        msehi         = 'A'
      )
      ( sdm_status    = '01'
        atinn         = '0000000006'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 100
        atflb         = 10000
        chr_data_type = 'CURR'
        msehi         = 'EUR'
      )
      ( sdm_status    = '01'
        atinn         = '0000000007'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 20190101
        atflb         = 20191231
        chr_data_type = 'DATE'
        msehi         = 'B'
      )
      ( sdm_status    = '01'
        atinn         = '0000000008'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 112233
        atflb         = 223344
        chr_data_type = 'TIME'
        msehi         = 'C'
      )
      ( sdm_status    = '02'
        atinn         = '0000000009'
        atzhl         = '0001'
        adzhl         = '0000'
        atflv         = 0
        atflb         = 0
        chr_data_type = 'NUM'
        msehi         = 'D'
      )
    ).

    SELECT * FROM p_clfnsdmcawn INTO TABLE @DATA(lt_p_clfnsdmcawn_act).

    cl_abap_unit_assert=>assert_equals(
      act = lt_p_clfnsdmcawn_act
      exp = lt_p_clfnsdmcawn_exp
    ).

  ENDMETHOD.