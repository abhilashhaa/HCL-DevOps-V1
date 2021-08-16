  METHOD setup.

    DATA:
      lt_charc TYPE STANDARD TABLE OF i_clfncharcbasic,
      lo_charc TYPE REF TO if_cds_test_data,
      lt_alloc TYPE STANDARD TABLE OF i_clfnclasscharcbasic,
      lo_alloc TYPE REF TO if_cds_test_data.


    mo_environment->clear_doubles( ).

    lt_alloc = VALUE #(
      ( charcinternalid = '0000000001' overwrittencharcinternalid = '1000000000' )
      ( charcinternalid = '0000000002' overwrittencharcinternalid = '2000000000' ) ).

    lo_alloc = cl_cds_test_data=>create( lt_alloc ).
    DATA(lo_alloc_stub) = mo_environment->get_double( 'i_clfnclasscharcbasic' ).
    lo_alloc_stub->insert( lo_alloc ).

    lt_charc = VALUE #(
      ( charcinternalid    = '0000000001'
        timeintervalnumber = '001'
        characteristic = 'TEST_CHAR_01'
        valueintervalisallowed = abap_true
        additionalvalueisallowed = abap_true
        charcisreadonly = abap_true
        charcishidden = abap_true
        charcentryisnotformatctrld = abap_true
        charctemplateisdisplayed = abap_true
        entryisrequired = abap_true
        multiplevaluesareallowed = abap_true
        charcidentificationcode = '' )

      ( charcinternalid = '1000000000'
        valueintervalisallowed = '*'
        additionalvalueisallowed = '*'
        charcisreadonly = '*'
        charcishidden = '*'
        charcentryisnotformatctrld = '*'
        charctemplateisdisplayed = '*'
        entryisrequired = '*'
        multiplevaluesareallowed = '*'
        charcidentificationcode = 'KL' )

      ( charcinternalid = '0000000002'
        timeintervalnumber = '001'
        characteristic = 'TEST_CHAR_02'
        valueintervalisallowed = abap_false
        additionalvalueisallowed = abap_false
        charcisreadonly = abap_false
        charcishidden = abap_false
        charcentryisnotformatctrld = abap_false
        charctemplateisdisplayed = abap_false
        entryisrequired = abap_false
        multiplevaluesareallowed = abap_false
        charcidentificationcode = '' )

      ( charcinternalid = '2000000000'
        valueintervalisallowed = abap_true
        additionalvalueisallowed = abap_true
        charcisreadonly = abap_true
        charcishidden = abap_true
        charcentryisnotformatctrld = abap_true
        charctemplateisdisplayed = abap_true
        entryisrequired = abap_true
        multiplevaluesareallowed = abap_true
        charcidentificationcode = 'KL' ) ).

    lo_charc = cl_cds_test_data=>create( lt_charc ).
    DATA(lo_charc_stub) = mo_environment->get_double( 'i_clfncharcbasic' ).
    lo_charc_stub->insert( lo_charc ).

  ENDMETHOD.