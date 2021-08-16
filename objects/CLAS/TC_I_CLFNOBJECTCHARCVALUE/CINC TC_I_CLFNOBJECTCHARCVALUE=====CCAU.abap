*"* use this source file for your ABAP unit test classes
"! @testing I_Clfnobjectcharcvalue
CLASS ltc_i_clfnobjectcharcvalue DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.
    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    DATA:
      act_results TYPE STANDARD TABLE OF i_clfnobjectcharcvalue WITH EMPTY KEY.

    METHODS:
      setup,
      check       FOR TESTING,
      check_objectid       FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfnobjectcharcvalue IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnobjectCharcValue' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_single TYPE STANDARD TABLE OF p_clfnsingleobjectcharcvalue WITH EMPTY KEY,
          lt_multi  TYPE STANDARD TABLE OF p_clfnmultipleobjectcharcvalue WITH EMPTY KEY,
          lo_single TYPE REF TO if_cds_test_data,
          lo_multi  TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_single = VALUE #(
      ( clfnobjectid = 'PB_TEST_MAT03E'
        clfnobjecttable = 'MARA'
        charcinternalid = '30636'
        charcvaluepositionnumber = '001'
        classtype = 'AU0'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvalue         = 'ABC'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03E'
        clfnobjecttable = 'MARA'
        charcinternalid = '30637'
        charcvaluepositionnumber = '001'
        classtype = 'AU0'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        charcvalue         = 'BCD'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03F'
        clfnobjecttable = 'MARA'
        charcinternalid = '30636'
        charcvaluepositionnumber = '001'
        classtype = 'AU0'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvalue         = 'EDC'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03F'
        clfnobjecttable = 'MARA'
        charcinternalid = '30636'
        charcvaluepositionnumber = '001'
        classtype = 'AU0'
        clfnobjecttype = 'O'
        charcvalue         = 'DCF'
        timeintervalnumber = '0001'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )

    ).
    lo_single = cl_cds_test_data=>create( i_data = lt_single ).
    DATA(lo_single_stub) = environment->get_double( i_name = 'P_ClfnSingleobjectcharcvalue' ).
    lo_single_stub->insert( lo_single ).

    lt_multi = VALUE #(
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjectinternalid = '000000000001124560'
        clfnobjecttable = 'MARA'
        charcinternalid = '30636'
        classtype = 'AU1'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvaluedependency = 1
        charcvalue         = 'AAA'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjectinternalid = '000000000001124560'
        clfnobjecttable = 'MARA'
        charcinternalid = '30637'
        classtype = 'AU1'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvaluedependency = 1
        charcvalue         = 'BBB'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjectinternalid = '000000000001124629'
        clfnobjecttable = 'MARA'
        charcinternalid = '28756'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvaluedependency = 1
        charcvalue         = 'JJ'
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjectinternalid = '000000000001124629'
        clfnobjecttable = 'MARA'
        charcinternalid = '28757'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvaluedependency = 1
        charcvalue         = 'GG'
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjectinternalid = '000000000001124629'
        clfnobjecttable = 'MARA'
        charcinternalid = '28767'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvaluedependency = 1
        charcvalue         = 'HH'
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjectinternalid = '000000000001124629'
        clfnobjecttable = 'MARA'
        charcinternalid = '28768'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvaluedependency = 1
        charcvalue         = 'DD'
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03E'
        clfnobjectinternalid = '000000000001121321'
        clfnobjecttable = 'MARA'
        charcinternalid = '30636'
        classtype = 'AU1'
        clfnobjecttype = 'O'
        timeintervalnumber = '0001'
        charcvaluedependency = 1
        charcvalue         = 'ABC'
        isdeleted           = abap_true
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
    ).
    lo_multi = cl_cds_test_data=>create( i_data = lt_multi ).
    DATA(lo_multi_stub) = environment->get_double( i_name = 'P_ClfnMultipleObjectCharcValue' ).
    lo_multi_stub->insert( lo_multi ).

  ENDMETHOD.

  METHOD check.

    SELECT *
     FROM
        i_clfnobjectcharcvalue
     WHERE clfnobjecttable = 'MARA'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 11 ).

  ENDMETHOD.

  METHOD check_objectid.

    SELECT *
     FROM
        i_clfnobjectcharcvalue
     WHERE clfnobjecttable = 'MARA'
     and   clfnobjectid = 'PB_TEST_MAT03E'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 3 ).

  ENDMETHOD.

ENDCLASS.

**"* use this source file for your ABAP unit test classes
*"! @testing I_ClfnObjectCharcValue
*CLASS ltc_i_clfnobjectcharcvalue DEFINITION FOR TESTING
*  DURATION SHORT
*  RISK LEVEL HARMLESS
*  FINAL.
*
*  PRIVATE SECTION.
*    CLASS-DATA:
*      environment TYPE REF TO if_cds_test_environment.
*
*    CLASS-METHODS:
*      class_setup,
*      class_teardown.
*
*    DATA:
*      act_results TYPE STANDARD TABLE OF i_clfnobjectcharcvalue WITH EMPTY KEY.
*
*    METHODS:
*      setup,
*      check       FOR TESTING,
*      check_objectid       FOR TESTING.
*
*ENDCLASS.
*
*CLASS ltc_i_clfnobjectcharcvalue IMPLEMENTATION.
*  METHOD class_setup.
*    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnobjectCharcValue' ).
*  ENDMETHOD.
*
*  METHOD class_teardown.
*    environment->destroy( ).
*  ENDMETHOD.
*
*  METHOD setup.
*    DATA: lt_objectcharcvaluebasic TYPE STANDARD TABLE OF i_clfnobjectcharcvaluebasic WITH EMPTY KEY,
*          lt_objectheader          TYPE STANDARD TABLE OF p_clfnobjectheader WITH EMPTY KEY,
*          lo_objectheader          TYPE REF TO if_cds_test_data,
*          lo_objectcharcvalue      TYPE REF TO if_cds_test_data.
*
*    environment->clear_doubles( ).
*
*    lt_objectheader = VALUE #(
*      ( classtype       = 'AU0'
*        clfnobjecttable = 'MARA'
*        clfnobjecttype  = 'O'
*        clfnobjectid    = 'PB_TEST_MAT03E'
*        objekp          = 'PB_TEST_MAT03E' )
*      ( classtype       = 'AU0'
*        clfnobjecttype  = 'O'
*        clfnobjecttable = 'MARA'
*        clfnobjectid    = 'PB_TEST_MAT03F'
*        objekp          = 'PB_TEST_MAT03F' )
*      ( classtype       = 'AU2'
*        clfnobjecttype  = 'O'
*        clfnobjecttable = 'MARA'
*        clfnobjectid    = '103'
*        objekp          = '103' )
*      ( classtype       = 'AU1'
*        clfnobjecttype  = 'O'
*        clfnobjecttable = 'MARA'
*        clfnobjectid    = '104'
*        objekp          = '104' )
*        "multi-object enabled class types
*      ( classtype       = 'AU1'
*        clfnobjecttype  = 'O'
*        clfnobjecttable = 'MARA'
*        clfnobjectid    = 'PB_TEST_MAT03H'
*        clfnobjectinternalid = '000000000001124630'
*        objekp          = '000000000001124560' )
*      ( classtype       = 'AU2'
*        clfnobjecttype  = 'O'
*        clfnobjecttable = 'MARA'
*        clfnobjectid    = 'PB_TEST_MAT03H'
*        clfnobjectinternalid = '000000000001124630'
*        objekp          = '000000000001124629' )
*    ).
*    lo_objectheader = cl_cds_test_data=>create( i_data = lt_objectheader ).
*    DATA(lo_classtype_stub) = environment->get_double( i_name = 'P_ClfnObjectHeader' ).
*    lo_classtype_stub->insert( lo_objectheader ).
*
*    lt_objectcharcvaluebasic = VALUE #(
*      ( clfnobjectid = 'PB_TEST_MAT03E'
*        charcinternalid = '30636'
*        charcvaluepositionnumber = '001'
*        classtype = 'AU0'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvalue         = 'ABC'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = 'PB_TEST_MAT03E'
*        charcinternalid = '30637'
*        charcvaluepositionnumber = '001'
*        classtype = 'AU0'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        charcvalue         = 'BCD'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = 'PB_TEST_MAT03F'
*        charcinternalid = '30636'
*        charcvaluepositionnumber = '001'
*        classtype = 'AU0'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvalue         = 'EDC'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = 'PB_TEST_MAT03F'
*        charcinternalid = '30636'
*        charcvaluepositionnumber = '001'
*        classtype = 'AU0'
*        clfnobjecttype = 'O'
*        charcvalue         = 'DCF'
*        timeintervalnumber = '0001'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      "multi-object enabled class types
*      ( clfnobjectid = '000000000001124560'
*        charcinternalid = '30636'
*        classtype = 'AU1'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvaluedependency = 1
*        charcvalue         = 'AAA'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124560'
*        charcinternalid = '30637'
*        classtype = 'AU1'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvaluedependency = 1
*        charcvalue         = 'BBB'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124629'
*        charcinternalid = '28756'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvaluedependency = 1
*        charcvalue         = 'JJ'
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124629'
*        charcinternalid = '28757'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvaluedependency = 1
*        charcvalue         = 'GG'
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124629'
*        charcinternalid = '28767'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvaluedependency = 1
*        charcvalue         = 'HH'
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124629'
*        charcinternalid = '28768'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0001'
*        charcvaluedependency = 1
*        charcvalue         = 'DD'
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*    ).
*    lo_objectcharcvalue = cl_cds_test_data=>create( i_data = lt_objectcharcvaluebasic ).
*    DATA(lo_objectcharcvalue_stub) = environment->get_double( i_name = 'I_ClfnObjectCharcValueBasic' ).
*    lo_objectcharcvalue_stub->insert( lo_objectcharcvalue ).
*
*  ENDMETHOD.
*
*  METHOD check.
*
*    SELECT *
*     FROM
*        i_clfnobjectcharcvalue
*     WHERE clfnobjecttable = 'MARA'
*     INTO TABLE @act_results.
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( act_results )
*      exp = 10 ).
*
*  ENDMETHOD.
*
*  METHOD check_objectid.
*
*    SELECT *
*     FROM
*        i_clfnobjectcharcvalue
*     WHERE clfnobjecttable = 'MARA'
*     AND   clfnobjectid = 'PB_TEST_MAT03E'
*     INTO TABLE @act_results.
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( act_results )
*      exp = 2 ).
*
*  ENDMETHOD.
*
*ENDCLASS.