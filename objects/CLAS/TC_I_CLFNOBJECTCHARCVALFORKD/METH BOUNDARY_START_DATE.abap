  METHOD boundary_start_date.

    DATA:
      lt_expected TYPE STANDARD TABLE OF i_clfnobjectcharcvalforkeydate.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    SELECT * FROM i_clfnobjectcharcvalforkeydate( p_keydate = '20160101' )
      INTO TABLE @DATA(lt_result).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    lt_expected = VALUE #(
      ( clfnobjectid             = 'OBJECT_1'
        clfnobjecttable          = 'MARA'
        charcinternalid          = '0000000001'
        charcvaluepositionnumber = 1
        clfnobjecttype           = 'O'
        classtype                = '001'
        charcvalue               = 'VALUE01'
        validitystartdate        = '20000101'
        validityenddate          = '20181231' )
      ( clfnobjectid             = 'OBJECT_2'
        clfnobjecttable          = 'MARA'
        charcinternalid          = '0000000002'
        charcvaluepositionnumber = 1
        clfnobjecttype           = 'O'
        classtype                = '001'
        charcvalue               = 111
        validitystartdate        = '20160101'
        validityenddate          = '20181231' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_result
      exp = lt_expected ).

  ENDMETHOD.