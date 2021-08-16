  METHOD check.

    DATA:
      lt_p_clfnsdmclfhdr_act TYPE TABLE OF P_ClfnSdmClfhdr,
      lt_p_clfnsdmclfhdr_exp TYPE TABLE OF P_ClfnSdmClfhdr.

    " Preparation
    environment->get_access_control_double( )->disable_access_control( ).
    lt_p_clfnsdmclfhdr_exp = VALUE #(
      ( obtab = 'MARA' objek = 'OBJ1' mafid = 'O' klart = '002' objekp = 'OBJ1' cuobj = 0 tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER' sdm_status = '1' )
      ( obtab = 'MARA' objek = 'OBJ2' mafid = 'O' klart = '001' objekp = '000000000000000122' cuobj = 122 tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER' sdm_status = '2' )
      ( obtab = 'EQUI' objek = 'OBJ3' mafid = 'O' klart = '002' objekp = 'OBJ3' cuobj = 0 tstmp_i = '1' user_i = '' tstmp_c = '' user_c = '' sdm_status = '3' )
      ( obtab = 'MARA' objek = 'OBJ4' mafid = 'O' klart = '001' objekp = '000000000000000124' cuobj = 124 tstmp_i = '1' user_i = '' tstmp_c = '' user_c = '' sdm_status = '4' )
      ( obtab = 'KLAH' objek = '0000000125' mafid = 'K' klart = '001' objekp = '' cuobj = 0 tstmp_i = '1' user_i = '' tstmp_c = '' user_c = '' sdm_status = '5' )
    ).

    " Get the results from the view.
    SELECT *
      FROM P_ClfnSdmClfhdr
      INTO TABLE @lt_p_clfnsdmclfhdr_act.

    " We have to overwrite tstmp_i with the expected, because we can not check it.
    lt_p_clfnsdmclfhdr_act[ 3 ]-tstmp_i = lt_p_clfnsdmclfhdr_exp[ 3 ]-tstmp_i.
    lt_p_clfnsdmclfhdr_act[ 4 ]-tstmp_i = lt_p_clfnsdmclfhdr_exp[ 4 ]-tstmp_i.
    lt_p_clfnsdmclfhdr_act[ 5 ]-tstmp_i = lt_p_clfnsdmclfhdr_exp[ 5 ]-tstmp_i.

    " Check the results.
    cl_abap_unit_assert=>assert_equals(
      act = lt_p_clfnsdmclfhdr_act
      exp = lt_p_clfnsdmclfhdr_exp
    ).

  ENDMETHOD.