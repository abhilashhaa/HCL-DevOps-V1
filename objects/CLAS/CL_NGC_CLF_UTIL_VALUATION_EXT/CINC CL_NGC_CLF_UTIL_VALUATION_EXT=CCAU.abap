*"* use this source file for your ABAP unit test classes

*  1 EQ         =  V1
*  2 GE  LT     >= V1   <  V2
*  3 GE  LE     >= V1   <= V2
*  4 GT  LT     >  V1   <  V2
*  5 GT  LE     >  V1   <= V2
*  6 LT         <  V1
*  7 LE         <= V1
*  8 GT         >  V1
*  9 GE         >= V1

CLASS ltc_ngc_clf_util_val_ext DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.
    CLASS-DATA:
      mo_cut                   TYPE REF TO cl_ngc_clf_util_valuation_ext,
      mt_characteristic_header TYPE ngct_characteristic.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup,
      check_time      FOR TESTING,
      check_date      FOR TESTING,
      check_currency  FOR TESTING,
      check_decimal   FOR TESTING.

ENDCLASS.

CLASS cl_ngc_clf_util_valuation_ext DEFINITION LOCAL FRIENDS ltc_ngc_clf_util_val_ext.

CLASS ltc_ngc_clf_util_val_ext IMPLEMENTATION.
  METHOD class_setup.
    mo_cut = cl_ngc_clf_util_valuation_ext=>get_instance( ).
  ENDMETHOD.

  METHOD class_teardown.
  ENDMETHOD.

  METHOD setup.
    mt_characteristic_header = VALUE ngct_characteristic(
      ( charcinternalid = '0000010886' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charclength = 3  charcdecimals = 2 )
      ( charcinternalid = '0000010888' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charclength = 5  charcdecimals = 3 negativevalueisallowed = abap_true )
      ( charcinternalid = '0000010889' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charclength = 5  charcdecimals = 3 negativevalueisallowed = abap_true )
      ( charcinternalid = '0000010890' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charclength = 8  charcdecimals = 2 negativevalueisallowed = abap_true )
      ( charcinternalid = '0000010891' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charclength = 4  charcdecimals = 0 negativevalueisallowed = abap_true )
      ( charcinternalid = '0000012672' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charclength = 21 charcdecimals = 4 negativevalueisallowed = abap_true )
      ( charcinternalid = '0000012673' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charclength = 10 charcdecimals = 4 )
      ( charcinternalid = '0000010892' charcdatatype = if_ngc_c=>gc_charcdatatype-curr charclength = 8  charcdecimals = 2 )
      ( charcinternalid = '0000010894' charcdatatype = if_ngc_c=>gc_charcdatatype-curr charclength = 10  charcdecimals = 0 charcvalueunit = 'JPY'  )
      ( charcinternalid = '0000012668' charcdatatype = if_ngc_c=>gc_charcdatatype-curr charclength = 10  charcdecimals = 0 negativevalueisallowed = abap_true charcvalueunit = 'EUR'  )
      ( charcinternalid = '0000012670' charcdatatype = if_ngc_c=>gc_charcdatatype-curr charclength = 10  charcdecimals = 0 charcvalueunit = 'EUR'  )
      ( charcinternalid = '0000010893' charcdatatype = if_ngc_c=>gc_charcdatatype-curr charclength = 5  charcdecimals = 2  negativevalueisallowed = abap_true charcvalueunit = 'USD'  )
      ( charcinternalid = '0000010895' charcdatatype = if_ngc_c=>gc_charcdatatype-date charclength = 10 charcdecimals = 0 )
      ( charcinternalid = '0000010896' charcdatatype = if_ngc_c=>gc_charcdatatype-time charclength = 8  charcdecimals = 0 )
    ).
  ENDMETHOD.

  METHOD check_currency.
    DATA ls_characteristic_header TYPE ngcs_characteristic.

    DATA(lt_valuation_data_ins) = VALUE ngct_valuation_data(
     ( charcinternalid = '0000010893' charcvaluedependency = 1 charcfromnumericvalue = '-2.2000000000000000E+01'  currency = 'USD' )
     ( charcinternalid = '0000010894' charcvaluedependency = 1 charcfromnumericvalue = '4.5633300000000000E+05'  currency = 'JPY' )
     ( charcinternalid = '0000010893' charcvaluedependency = 2 charcfromnumericvalue = '-2.2000000000000000E+01' charctonumericvalue = '3.4000000000000000E+01' currency = 'USD' )
     ( charcinternalid = '0000010893' charcvaluedependency = 2 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0500000000000000E+01' currency = 'USD' )
     ( charcinternalid = '0000012670' charcvaluedependency = 3 charcfromnumericvalue = '-1.000000000000000E+03'  charctonumericvalue = '-1.000000000000000E+01' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 4 charcfromnumericvalue = '1.000000000000000E+01'  charctonumericvalue = '1.000000000000000E+03' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 4 charcfromnumericvalue = '-1.000000000000000E+03'  charctonumericvalue = '-1.000000000000000E+01' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 5 charcfromnumericvalue = '-1.000000000000000E+03'  charctonumericvalue = '0.000000000000000E+00' currency = 'EUR' )
     ( charcinternalid = '0000012670' charcvaluedependency = 6 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 7 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' currency = 'EUR' )
     ( charcinternalid = '0000012670' charcvaluedependency = 8 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' currency = 'EUR' )
     ( charcinternalid = '0000012670' charcvaluedependency = 9 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' currency = 'EUR' )
    ).
    DATA(lt_valuation_data_exp) = VALUE ngct_valuation_data(
     ( charcinternalid = '0000010893' charcvaluedependency = 1 charcfromnumericvalue = '-2.2000000000000000E+01' charcfromamount = '22.00-' charctoamount = '22.00-' currency = 'USD' )
     ( charcinternalid = '0000010894' charcvaluedependency = 1 charcfromnumericvalue = '4.5633300000000000E+05' charcfromamount = '4563.33' charctoamount = '4563.33' currency = 'JPY' )
     ( charcinternalid = '0000010893' charcvaluedependency = 2 charcfromnumericvalue = '-2.2000000000000000E+01' charctonumericvalue = '3.4000000000000000E+01' charcfromamount = '22.00-' charctoamount = '33.99' currency = 'USD' )
     ( charcinternalid = '0000010893' charcvaluedependency = 2 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0500000000000000E+01' charcfromamount = '2.00'   charctoamount = '20.49' currency = 'USD' )
     ( charcinternalid = '0000012670' charcvaluedependency = 3 charcfromnumericvalue = '-1.000000000000000E+03'  charctonumericvalue = '-1.000000000000000E+01' charcfromamount = '-1000.00' charctoamount = '-10.00' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 4 charcfromnumericvalue = '1.000000000000000E+01'  charctonumericvalue = '1.000000000000000E+03' charcfromamount = '10.01' charctoamount = '999.99' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 4 charcfromnumericvalue = '-1.000000000000000E+03'  charctonumericvalue = '-1.000000000000000E+01' charcfromamount = '-999.99' charctoamount = '-10.01' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 5 charcfromnumericvalue = '-1.000000000000000E+03'  charctonumericvalue = '0.000000000000000E+00' charcfromamount = '-999.99' charctoamount = '0.00' currency = 'EUR' )
     ( charcinternalid = '0000012670' charcvaluedependency = 6 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' charcfromamount = '-99999999.99' charctoamount = '999.99' currency = 'EUR' )
     ( charcinternalid = '0000012668' charcvaluedependency = 7 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' charcfromamount = '-99999999.99' charctoamount = '1000.00' currency = 'EUR' )
     ( charcinternalid = '0000012670' charcvaluedependency = 8 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' charcfromamount = '1000.01' charctoamount = '99999999.99' currency = 'EUR' )
     ( charcinternalid = '0000012670' charcvaluedependency = 9 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' charcfromamount = '1000.00' charctoamount = '99999999.99' currency = 'EUR' )
    ).

    LOOP AT lt_valuation_data_ins ASSIGNING FIELD-SYMBOL(<ls_valuation_data_ins>).
      IF <ls_valuation_data_ins>-charcinternalid NE ls_characteristic_header-charcinternalid.
        READ TABLE mt_characteristic_header INTO ls_characteristic_header
        WITH KEY charcinternalid = <ls_valuation_data_ins>-charcinternalid.
      ENDIF.
      mo_cut->calculate_valuation_extension(
        EXPORTING
          is_characteristic_header = ls_characteristic_header
        CHANGING
          cs_valuation_data        = <ls_valuation_data_ins>
        ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_equals(
      act = lt_valuation_data_ins
      exp = lt_valuation_data_exp
      msg = 'VALUATION EXT: currency format extension failed' ).

    " check overflow
    DATA(ls_valuation_data_ins) = VALUE ngcs_valuation_data( charcinternalid = '0000010894' charcvaluedependency = 1 charcfromnumericvalue = '4.5633300000000000E+25'  currency = 'JPY' ) ##LITERAL.
    mo_cut->calculate_valuation_extension(
      EXPORTING
        is_characteristic_header = ls_characteristic_header
      CHANGING
        cs_valuation_data        = ls_valuation_data_ins
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = ls_valuation_data_ins-currency
      exp   = ''
      msg = 'VALUATION EXT: currency overflow failed'
    ).

    " check boundaries overflow > conversion error, amounts are not set
    ls_valuation_data_ins = VALUE ngcs_valuation_data( charcinternalid = '0000010894' charcvaluedependency = 2 charcfromnumericvalue = '-4.5633300000000000E+05' charctonumericvalue = '4.5633300000000000E+25' currency = 'USD' ) ##LITERAL.
*    " check default
    mo_cut->calculate_valuation_extension(
      EXPORTING
        is_characteristic_header = ls_characteristic_header
      CHANGING
        cs_valuation_data        = ls_valuation_data_ins
      ).

    cl_abap_unit_assert=>assert_equals(
      act   = ls_valuation_data_ins-charcfromamount
      exp   = 0
      msg = 'VALUATION EXT: currency boundaries overflow failed'
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = ls_valuation_data_ins-charctoamount
      exp   = 0
      msg = 'VALUATION EXT: currency boundaries overflow failed'
    ).

  ENDMETHOD.

  METHOD check_time.

    READ TABLE mt_characteristic_header INTO DATA(ls_characteristic_header)
      WITH KEY charcinternalid = '0000010896'.
    DATA(lt_valuation_data_ins) = VALUE ngct_valuation_data(
      ( charcinternalid = '0000010896' charcvaluedependency = 1 charcfromnumericvalue = '1.6123000000000000E+05' charctonumericvalue = '0.0000000000000000E+00' )
      ( charcinternalid = '0000010896' charcvaluedependency = 1 charcfromnumericvalue = '2.0103500000000000E+05' charctonumericvalue = '0.0000000000000000E+00' )
      ( charcinternalid = '0000010896' charcvaluedependency = 2 charcfromnumericvalue = '2.0103500000000000E+05' charctonumericvalue = '2.1163500000000000E+05' )
      ( charcinternalid = '0000010896' charcvaluedependency = 3 charcfromnumericvalue = '7.000000000000000E+04' charctonumericvalue = '1.700000000000000E+05' )
      ( charcinternalid = '0000010896' charcvaluedependency = 4 charcfromnumericvalue = '1.2020000000000000E+05' charctonumericvalue = '1.6123000000000000E+05' )
      ( charcinternalid = '0000010896' charcvaluedependency = 5 charcfromnumericvalue = '2.159590000000000E+05' charctonumericvalue = '2.300000000000000E+05' )
      ( charcinternalid = '0000010896' charcvaluedependency = 6 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '8.000000000000000E+04' )
      ( charcinternalid = '0000010896' charcvaluedependency = 7 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '1.200000000000000E+05' )
      ( charcinternalid = '0000010896' charcvaluedependency = 8 charcfromnumericvalue = '1.600000000000000E+05' charctonumericvalue = '2.3595900000000000E+05' )
      ( charcinternalid = '0000010896' charcvaluedependency = 9 charcfromnumericvalue = '7.000000000000000E+04' charctonumericvalue = '2.3595900000000000E+05' )
    ).

    DATA(lt_valuation_data_exp) = VALUE ngct_valuation_data(
      ( charcinternalid = '0000010896' charcvaluedependency = 1 charcfromnumericvalue = '1.6123000000000000E+05' charctonumericvalue = '0.0000000000000000E+00' charcfromtime = '161230' charctotime = '161230' )
      ( charcinternalid = '0000010896' charcvaluedependency = 1 charcfromnumericvalue = '2.0103500000000000E+05' charctonumericvalue = '0.0000000000000000E+00' charcfromtime = '201035' charctotime = '201035' )
      ( charcinternalid = '0000010896' charcvaluedependency = 2 charcfromnumericvalue = '2.0103500000000000E+05' charctonumericvalue = '2.1163500000000000E+05' charcfromtime = '201035' charctotime = '211634' )
      ( charcinternalid = '0000010896' charcvaluedependency = 3 charcfromnumericvalue = '7.000000000000000E+04' charctonumericvalue = '1.700000000000000E+05' charcfromtime = '070000' charctotime = '170000' )
      ( charcinternalid = '0000010896' charcvaluedependency = 4 charcfromnumericvalue = '1.2020000000000000E+05' charctonumericvalue = '1.6123000000000000E+05' charcfromtime = '120201' charctotime = '161229' )
      ( charcinternalid = '0000010896' charcvaluedependency = 5 charcfromnumericvalue = '2.159590000000000E+05' charctonumericvalue = '2.300000000000000E+05' charcfromtime = '220000' charctotime = '230000' )
      ( charcinternalid = '0000010896' charcvaluedependency = 6 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '8.000000000000000E+04' charcfromtime = '000000' charctotime = '075959' )
      ( charcinternalid = '0000010896' charcvaluedependency = 7 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '1.200000000000000E+05' charcfromtime = '000000' charctotime = '120000' )
      ( charcinternalid = '0000010896' charcvaluedependency = 8 charcfromnumericvalue = '1.600000000000000E+05' charctonumericvalue = '2.3595900000000000E+05' charcfromtime = '160001' charctotime = '235959' )
      ( charcinternalid = '0000010896' charcvaluedependency = 9 charcfromnumericvalue = '7.000000000000000E+04' charctonumericvalue = '2.3595900000000000E+05' charcfromtime = '070000' charctotime = '235959' )
    ).

    LOOP AT lt_valuation_data_ins ASSIGNING FIELD-SYMBOL(<ls_valuation_data_ins>).
      mo_cut->calculate_valuation_extension(
      EXPORTING
        is_characteristic_header = ls_characteristic_header
      CHANGING
        cs_valuation_data        = <ls_valuation_data_ins>
      ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_equals(
      act = lt_valuation_data_ins
      exp = lt_valuation_data_exp
      msg = 'VALUATION EXT: time format extension failed' ).

  ENDMETHOD.

  METHOD check_date.

    READ TABLE mt_characteristic_header INTO DATA(ls_characteristic_header)
      WITH KEY charcinternalid = '0000010895'.
    DATA(lt_valuation_data_ins) = VALUE ngct_valuation_data(
      ( charcinternalid = '0000010895' charcvaluedependency = 1 charcfromnumericvalue = '2.0160518000000000E+07' charctonumericvalue = '0.0000000000000000E+00' )
      ( charcinternalid = '0000010895' charcvaluedependency = 1 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '0.0000000000000000E+00' )
      ( charcinternalid = '0000010895' charcvaluedependency = 2 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160518000000000E+07' )
      ( charcinternalid = '0000010895' charcvaluedependency = 3 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160501000000000E+07' )
      ( charcinternalid = '0000010895' charcvaluedependency = 4 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160501000000000E+07' )
      ( charcinternalid = '0000010895' charcvaluedependency = 5 charcfromnumericvalue = '2.0160502000000000E+07' charctonumericvalue = '2.0160620000000000E+07' )
      ( charcinternalid = '0000010895' charcvaluedependency = 5 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160501000000000E+07' )
      ( charcinternalid = '0000010895' charcvaluedependency = 6 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '2.000010100000000E+07' )
      ( charcinternalid = '0000010895' charcvaluedependency = 7 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '2.001010100000000E+07' )
      ( charcinternalid = '0000010895' charcvaluedependency = 8 charcfromnumericvalue = '2.007123100000000E+07' charctonumericvalue = '1.000000000000000E+17' )
      ( charcinternalid = '0000010895' charcvaluedependency = 9 charcfromnumericvalue = '2.008123100000000E+07' charctonumericvalue = '1.000000000000000E+17' )


    ).

    DATA(lt_valuation_data_exp) = VALUE ngct_valuation_data(

      ( charcinternalid = '0000010895' charcvaluedependency = 1 charcfromnumericvalue = '2.0160518000000000E+07' charctonumericvalue = '0.0000000000000000E+00' charcfromdate = '20160518' charctodate = '20160518' )
      ( charcinternalid = '0000010895' charcvaluedependency = 1 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '0.0000000000000000E+00' charcfromdate = '20151117' charctodate = '20151117' )
      ( charcinternalid = '0000010895' charcvaluedependency = 2 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160518000000000E+07' charcfromdate = '20151117' charctodate = '20160517' )
      ( charcinternalid = '0000010895' charcvaluedependency = 3 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160501000000000E+07' charcfromdate = '20151117' charctodate = '20160501' )
      ( charcinternalid = '0000010895' charcvaluedependency = 4 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160501000000000E+07' charcfromdate = '20151118' charctodate = '20160430' )
      ( charcinternalid = '0000010895' charcvaluedependency = 5 charcfromnumericvalue = '2.0160502000000000E+07' charctonumericvalue = '2.0160620000000000E+07' charcfromdate = '20160503' charctodate = '20160620' )
      ( charcinternalid = '0000010895' charcvaluedependency = 5 charcfromnumericvalue = '2.0151117000000000E+07' charctonumericvalue = '2.0160501000000000E+07' charcfromdate = '20151118' charctodate = '20160501' )
      ( charcinternalid = '0000010895' charcvaluedependency = 6 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '2.000010100000000E+07' charcfromdate = '19000101' charctodate = '19991231')
      ( charcinternalid = '0000010895' charcvaluedependency = 7 charcfromnumericvalue = '0.000000000000000E+00' charctonumericvalue = '2.001010100000000E+07' charcfromdate = '19000101' charctodate = '20010101')
      ( charcinternalid = '0000010895' charcvaluedependency = 8 charcfromnumericvalue = '2.007123100000000E+07' charctonumericvalue = '1.000000000000000E+17' charcfromdate = '20080101' charctodate = '99991231')
      ( charcinternalid = '0000010895' charcvaluedependency = 9 charcfromnumericvalue = '2.008123100000000E+07' charctonumericvalue = '1.000000000000000E+17' charcfromdate = '20081231' charctodate = '99991231')
    ).

    LOOP AT lt_valuation_data_ins ASSIGNING FIELD-SYMBOL(<ls_valuation_data_ins>).
      mo_cut->calculate_valuation_extension(
      EXPORTING
        is_characteristic_header = ls_characteristic_header
      CHANGING
        cs_valuation_data        = <ls_valuation_data_ins>
      ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_equals(
      act = lt_valuation_data_ins
      exp = lt_valuation_data_exp
      msg = 'VALUATION EXT: date format extension failed' ).

  ENDMETHOD.

  METHOD check_decimal.

    DATA ls_characteristic_header TYPE ngcs_characteristic.

    DATA(lt_valuation_data_ins) = VALUE ngct_valuation_data(
      ( charcinternalid = '0000010886' charcvaluedependency = 1 charcfromnumericvalue = '4.0000000000000000E+00' )
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '-2.2000000000000000E+01' charctonumericvalue = '3.4000000000000000E+01' )
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0500000000000000E+01' )
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '-2.2111000000000000E+01' charctonumericvalue = '3.4000000000000000E+01' )
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '-2.2111000000000000E+01' charctonumericvalue = '-4.5000000000000000E+00' )
      ( charcinternalid = '0000010890' charcvaluedependency = 3 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0199999999999999E+01' )
      ( charcinternalid = '0000010890' charcvaluedependency = 3 charcfromnumericvalue = '-2.0000000000000000E+00' charctonumericvalue = '2.0199999999999999E+01' )
      ( charcinternalid = '0000010890' charcvaluedependency = 1 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '0.0000000000000000E+00' )
      ( charcinternalid = '0000010891' charcvaluedependency = 3 charcfromnumericvalue = '3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' )
      ( charcinternalid = '0000010891' charcvaluedependency = 1 charcfromnumericvalue = '7.0000000000000000E+02'  charctonumericvalue = '0.0000000000000000E+00' )
      ( charcinternalid = '0000010891' charcvaluedependency = 3 charcfromnumericvalue = '-3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' )
      ( charcinternalid = '0000010890' charcvaluedependency = 4 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0199999999999999E+01' )
      ( charcinternalid = '0000010890' charcvaluedependency = 4 charcfromnumericvalue = '-2.0000000000000000E+00' charctonumericvalue = '2.0199999999999999E+01' )
      ( charcinternalid = '0000010890' charcvaluedependency = 4 charcfromnumericvalue = '-2.0199999999999999E+01'  charctonumericvalue = '-2.0000000000000000E+00' )
      ( charcinternalid = '0000010891' charcvaluedependency = 4 charcfromnumericvalue = '3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' )
      ( charcinternalid = '0000010891' charcvaluedependency = 4 charcfromnumericvalue = '-3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' )
      ( charcinternalid = '0000010891' charcvaluedependency = 4 charcfromnumericvalue = '-5.2500000000000000E+02'  charctonumericvalue = '-3.4000000000000000E+01' )
      ( charcinternalid = '0000010890' charcvaluedependency = 5 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0199999999999999E+01' )
      ( charcinternalid = '0000010890' charcvaluedependency = 5 charcfromnumericvalue = '-2.0000000000000000E+00' charctonumericvalue = '2.0199999999999999E+01' )
      ( charcinternalid = '0000010890' charcvaluedependency = 5 charcfromnumericvalue = '-2.0199999999999999E+01'  charctonumericvalue = '-2.0000000000000000E+00' )
      ( charcinternalid = '0000010891' charcvaluedependency = 5 charcfromnumericvalue = '3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' )
      ( charcinternalid = '0000010891' charcvaluedependency = 5 charcfromnumericvalue = '-3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' )
      ( charcinternalid = '0000010891' charcvaluedependency = 5 charcfromnumericvalue = '-5.2500000000000000E+02'  charctonumericvalue = '-3.4000000000000000E+01' )
      ( charcinternalid = '0000012673' charcvaluedependency = 6 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' )
      ( charcinternalid = '0000012672' charcvaluedependency = 7 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' )
      ( charcinternalid = '0000012673' charcvaluedependency = 8 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' )
      ( charcinternalid = '0000012673' charcvaluedependency = 9 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' )
    ).
    DATA(lt_valuation_data_exp) = VALUE ngct_valuation_data(
      ( charcinternalid = '0000010886' charcvaluedependency = 1 charcfromnumericvalue = '4.0000000000000000E+00' charcfromdecimalvalue = '4.00' charctodecimalvalue = '4.00' )
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '-2.2000000000000000E+01'  charctonumericvalue = '3.4000000000000000E+01' charcfromdecimalvalue = '22.00000000000000-' charctodecimalvalue = '33.99900000000000')
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0500000000000000E+01' charcfromdecimalvalue = '2.000000000000000' charctodecimalvalue = '20.49900000000000' )
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '-2.2111000000000000E+01' charctonumericvalue = '3.4000000000000000E+01' charcfromdecimalvalue = '22.11100000000000-' charctodecimalvalue = '33.99900000000000' )
      ( charcinternalid = '0000010888' charcvaluedependency = 2 charcfromnumericvalue = '-2.2111000000000000E+01' charctonumericvalue = '-4.5000000000000000E+00' charcfromdecimalvalue = '22.11100000000000-' charctodecimalvalue = '4.501000000000000-' )
      ( charcinternalid = '0000010890' charcvaluedependency = 3 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0199999999999999E+01' charcfromdecimalvalue = '2.00' charctodecimalvalue = '20.20' )
      ( charcinternalid = '0000010890' charcvaluedependency = 3 charcfromnumericvalue = '-2.0000000000000000E+00' charctonumericvalue = '2.0199999999999999E+01' charcfromdecimalvalue = '-2.00' charctodecimalvalue = '20.20' )
      ( charcinternalid = '0000010890' charcvaluedependency = 1 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '0.0000000000000000E+00' charcfromdecimalvalue = '2.00' charctodecimalvalue = '2.00' )
      ( charcinternalid = '0000010891' charcvaluedependency = 3 charcfromnumericvalue = '3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' charcfromdecimalvalue = '34' charctodecimalvalue = '525' )
      ( charcinternalid = '0000010891' charcvaluedependency = 1 charcfromnumericvalue = '7.0000000000000000E+02'  charctonumericvalue = '0.0000000000000000E+00' charcfromdecimalvalue = '700' charctodecimalvalue = '700' )
      ( charcinternalid = '0000010891' charcvaluedependency = 3 charcfromnumericvalue = '-3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' charcfromdecimalvalue = '-34' charctodecimalvalue = '525' )
      ( charcinternalid = '0000010890' charcvaluedependency = 4 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0199999999999999E+01' charcfromdecimalvalue = '2.01' charctodecimalvalue = '20.19' )
      ( charcinternalid = '0000010890' charcvaluedependency = 4 charcfromnumericvalue = '-2.0000000000000000E+00' charctonumericvalue = '2.0199999999999999E+01' charcfromdecimalvalue = '-1.99' charctodecimalvalue = '20.19' )
      ( charcinternalid = '0000010890' charcvaluedependency = 4 charcfromnumericvalue = '-2.0199999999999999E+01'  charctonumericvalue = '-2.0000000000000000E+00' charcfromdecimalvalue = '-20.19' charctodecimalvalue = '-2.01' )
      ( charcinternalid = '0000010891' charcvaluedependency = 4 charcfromnumericvalue = '3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' charcfromdecimalvalue = '35' charctodecimalvalue = '524' )
      ( charcinternalid = '0000010891' charcvaluedependency = 4 charcfromnumericvalue = '-3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' charcfromdecimalvalue = '-33' charctodecimalvalue = '524' )
      ( charcinternalid = '0000010891' charcvaluedependency = 4 charcfromnumericvalue = '-5.2500000000000000E+02'  charctonumericvalue = '-3.4000000000000000E+01' charcfromdecimalvalue = '-524' charctodecimalvalue = '-35' )
      ( charcinternalid = '0000010890' charcvaluedependency = 5 charcfromnumericvalue = '2.0000000000000000E+00'  charctonumericvalue = '2.0199999999999999E+01' charcfromdecimalvalue = '2.01' charctodecimalvalue = '20.20' )
      ( charcinternalid = '0000010890' charcvaluedependency = 5 charcfromnumericvalue = '-2.0000000000000000E+00' charctonumericvalue = '2.0199999999999999E+01' charcfromdecimalvalue = '-1.99' charctodecimalvalue = '20.20' )
      ( charcinternalid = '0000010890' charcvaluedependency = 5 charcfromnumericvalue = '-2.0199999999999999E+01'  charctonumericvalue = '-2.0000000000000000E+00' charcfromdecimalvalue = '-20.19' charctodecimalvalue = '-2.00' )
      ( charcinternalid = '0000010891' charcvaluedependency = 5 charcfromnumericvalue = '3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' charcfromdecimalvalue = '35' charctodecimalvalue = '525' )
      ( charcinternalid = '0000010891' charcvaluedependency = 5 charcfromnumericvalue = '-3.4000000000000000E+01'  charctonumericvalue = '5.2500000000000000E+02' charcfromdecimalvalue = '-33' charctodecimalvalue = '525' )
      ( charcinternalid = '0000010891' charcvaluedependency = 5 charcfromnumericvalue = '-5.2500000000000000E+02'  charctonumericvalue = '-3.4000000000000000E+01' charcfromdecimalvalue = '-524' charctodecimalvalue = '-34' )
      ( charcinternalid = '0000012673' charcvaluedependency = 6 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' charcfromdecimalvalue = '-999999.9999' charctodecimalvalue = '999.9999')
      ( charcinternalid = '0000012672' charcvaluedependency = 7 charcfromnumericvalue = '-1.0000000000000000E+17'  charctonumericvalue = '1.000000000000000E+03' charcfromdecimalvalue = '-99999999999999999.9999' charctodecimalvalue = '1000.0000')
      ( charcinternalid = '0000012673' charcvaluedependency = 8 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' charcfromdecimalvalue = '1000.0001' charctodecimalvalue = '999999.9999' )
      ( charcinternalid = '0000012673' charcvaluedependency = 9 charcfromnumericvalue = '1.000000000000000E+03'  charctonumericvalue = '1.000000000000000E+17' charcfromdecimalvalue = '1000.0000' charctodecimalvalue = '999999.9999')
    ).

    LOOP AT lt_valuation_data_ins ASSIGNING FIELD-SYMBOL(<ls_valuation_data_ins>).

      IF <ls_valuation_data_ins>-charcinternalid NE ls_characteristic_header-charcinternalid.
        READ TABLE mt_characteristic_header INTO ls_characteristic_header
        WITH KEY charcinternalid = <ls_valuation_data_ins>-charcinternalid.
      ENDIF.
      mo_cut->calculate_valuation_extension(
        EXPORTING
          is_characteristic_header = ls_characteristic_header
        CHANGING
          cs_valuation_data        = <ls_valuation_data_ins>
        ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_equals(
      act = lt_valuation_data_ins
      exp = lt_valuation_data_exp
      msg = 'VALUATION EXT: decimal format extension failed' ).

  ENDMETHOD.


ENDCLASS.