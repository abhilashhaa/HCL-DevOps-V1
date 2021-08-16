  METHOD all_fields_without_overwrite.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(ls_expected) = VALUE p_clfncharcoverwrite(
      charcinternalid            = '2000000000'
      timeintervalnumber         = '001'
      characteristic             = 'TEST_CHAR_02'
      valueintervalisallowed     = abap_true
      additionalvalueisallowed   = abap_true
      charcisreadonly            = abap_true
      charcishidden              = abap_true
      charcentryisnotformatctrld = abap_true
      charctemplateisdisplayed   = abap_true
      entryisrequired            = abap_true
      multiplevaluesareallowed   = abap_true ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    SELECT SINGLE * FROM p_clfncharcoverwrite
      INTO @DATA(ls_charc)
      WHERE
        charcinternalid = '2000000000'.

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = ls_charc
      exp = ls_expected ).

  ENDMETHOD.