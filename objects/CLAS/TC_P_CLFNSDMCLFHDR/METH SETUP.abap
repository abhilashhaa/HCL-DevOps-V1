  METHOD setup.

    DATA:
      lt_tcla    TYPE TABLE OF tcla,
      lt_clf_hdr TYPE TABLE OF clf_hdr,
      lt_kssk    TYPE TABLE OF kssk,
      lt_inob    TYPE TABLE OF inob.

    environment->clear_doubles( ).

    lt_tcla = VALUE #(
      (
        klart = '001'
        obtab = 'MARA'
        multobj = 'X'
      )
      (
        klart = '002'
        obtab = 'EQUI'
        multobj = ' '
      )
    ).
    DATA(lo_tcla) = cl_cds_test_data=>create( lt_tcla ).
    environment->get_double( 'TCLA' )->insert( lo_tcla ).

    lt_clf_hdr = VALUE #(
      ( " status=1.
        obtab = 'MARA'
        objek = 'OBJ1'
        mafid = 'O'
        klart = '002'
        objekp = ''
        cuobj = 0
        tstmp_i = '1'
        user_i = 'TESTUSER'
        tstmp_c = '1'
        user_c = 'TESTUSER'
      )
      ( " status=2.
        obtab = 'MARA'
        objek = 'OBJ2'
        mafid = 'O'
        klart = '001'
        objekp = ''
        cuobj = 122
        tstmp_i = '1'
        user_i = 'TESTUSER'
        tstmp_c = '1'
        user_c = 'TESTUSER'
      )
    ).
    DATA(lo_clf_hdr) = cl_cds_test_data=>create( lt_clf_hdr ).
    environment->get_double( 'CLF_HDR' )->insert( lo_clf_hdr ).

    lt_kssk = VALUE #(
      ( " status=3.
        objek = 'OBJ3'
        mafid = 'O'
        klart = '002'
        clint = 123
        adzhl = 0
      )
      ( " status=4.
        objek = '000000000000000124'
        mafid = 'O'
        klart = '001'
        clint = 124
        adzhl = 0
      )
      ( " status=5.
        objek = '0000000125'
        mafid = 'K'
        klart = '001'
        clint = 126
        adzhl = 0
      )
    ).
    DATA(lo_kssk) = cl_cds_test_data=>create( lt_kssk ).
    environment->get_double( 'KSSK' )->insert( lo_kssk ).

    lt_inob = VALUE #(
      ( " status=4.
        cuobj = 124
        klart = '001'
        obtab = 'MARA'
        objek = 'OBJ4'
      )
    ).
    DATA(lo_inob) = cl_cds_test_data=>create( lt_inob ).
    environment->get_double( 'INOB' )->insert( lo_inob ).

  ENDMETHOD.