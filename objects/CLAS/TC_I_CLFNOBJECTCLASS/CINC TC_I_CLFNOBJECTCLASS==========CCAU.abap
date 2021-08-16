*"* use this source file for your ABAP unit test classes
"! @testing I_ClfnObjectClass
CLASS ltc_i_clfnobjectclass DEFINITION FOR TESTING
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
      act_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY.

    METHODS:
      setup,
      check                         FOR TESTING,
      check_objectid                FOR TESTING,
      check_empty_objectinternalid  FOR TESTING,
      check_all_dcl                 FOR TESTING,
      check_maint_dcl               FOR TESTING,
      check_classif_dcl             FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfnobjectclass IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create(
      i_for_entity      = 'I_ClfnObjectClass'
      test_associations = abap_true
    ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_single TYPE STANDARD TABLE OF p_clfnsingleobjectclass WITH EMPTY KEY,
          lt_multi  TYPE STANDARD TABLE OF p_clfnmultipleobjectclass WITH EMPTY KEY,
          lt_class  TYPE STANDARD TABLE OF i_clfnclass WITH EMPTY KEY,
          lo_class  TYPE REF TO if_cds_test_data,
          lo_single TYPE REF TO if_cds_test_data,
          lo_multi  TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_single = VALUE #(
      ( clfnobjectid = 'PB_TEST_MAT03E'
        clfnobjecttable = 'MARA'
        classinternalid = '101'
        classtype = 'AU1'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '10'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03F'
        clfnobjecttable = 'MARA'
        classinternalid = '102'
        classtype = 'AU1'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '10'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03F'
        clfnobjecttable = 'MARA'
        classinternalid = '103'
        classtype = 'AU1'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = '103'
        clfnobjecttable = 'MARA'
        classinternalid = '105'
        classtype = 'AU1'
        clfnobjecttype = 'K'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '10'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = '104'
        clfnobjecttable = 'MARA'
        classinternalid = '105'
        classtype = 'AU1'
        clfnobjecttype = 'K'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
    ).
    lo_single = cl_cds_test_data=>create( i_data = lt_single ).
    DATA(lo_single_stub) = environment->get_double( i_name = 'P_ClfnSingleObjectClass' ).
    lo_single_stub->insert( lo_single ).

    lt_multi = VALUE #(
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjecttable = 'MARA'
        classinternalid = '110'
        clfnobjectinternalid = '000000000001124560'
        classtype = 'AU1'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '10'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjecttable = 'MARA'
        classinternalid = '111'
        clfnobjectinternalid = '000000000001124629'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '10'
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjecttable = 'MARA'
        classinternalid = '112'
        clfnobjectinternalid = '000000000001124629'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjecttable = 'MARA'
        classinternalid = '113'
        clfnobjectinternalid = '000000000001124629'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        isdeleted   = abap_true
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03G'
        clfnobjecttable = 'MARA'
        classinternalid = '114'
        clfnobjectinternalid = '000000000001124629'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        isdeleted   = abap_true
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03G'
        clfnobjecttable = 'MARA'
        classinternalid = '115'
        clfnobjectinternalid = '000000000001124629'
        classtype = 'AU2'
        clfnobjecttype = 'O'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        isdeleted   = abap_true
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
    ).
    lo_multi = cl_cds_test_data=>create( i_data = lt_multi ).
    DATA(lo_multi_stub) = environment->get_double( i_name = 'P_ClfnMultipleObjectClass' ).
    lo_multi_stub->insert( lo_multi ).

    lt_class = VALUE #(
      ( classinternalid       = '111'
        class                 = '111'
        classtype             = 'AU2'
        classclassfctnauthgrp = ''
        classmaintauthgrp     = 'AAA'
        validitystartdate     = '20180201'
        validityenddate       = '99991231' )
      ( classinternalid       = '112'
        class                 = '112'
        classtype             = 'AU2'
        classclassfctnauthgrp = ''
        classmaintauthgrp     = 'BBB'
        validitystartdate     = '20180201'
        validityenddate       = '99991231' )
      ( classinternalid       = '113'
        class                 = '113'
        classtype             = 'AU2'
        classclassfctnauthgrp = 'ZZZ'
        classmaintauthgrp     = ''
        validitystartdate     = '20180201'
        validityenddate       = '99991231' )
      ( classinternalid       = '114'
        class                 = '114'
        classtype             = 'AU2'
        classclassfctnauthgrp = ''
        classmaintauthgrp     = ''
        validitystartdate     = '20180201'
        validityenddate       = '99991231' )
      ( classinternalid       = '115'
        class                 = '115'
        classtype             = 'AU2'
        classclassfctnauthgrp = 'ZZZ'
        classmaintauthgrp     = 'AAA'
        validitystartdate     = '20180201'
        validityenddate       = '99991231' )
    ).
    lo_class = cl_cds_test_data=>create( i_data = lt_class ).
    DATA(lo_class_stub) = environment->get_double( i_name = 'I_ClfnClass' ).
    lo_class_stub->insert( lo_class ).

  ENDMETHOD.
METHOD check_all_dcl.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY,
          act_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY.
    " enable dcl without authorization for the objects -> no result expected
    DATA(acm_data_no_authorization) = cl_cds_test_data=>create_access_control_data( i_role_authorizations = VALUE #( ) ).
    environment->get_access_control_double( )->disable_access_control( )."enable_access_control( i_access_control_data = acm_data_no_authorization ).
    environment->get_access_control_double( )->enable_access_control( i_access_control_data = acm_data_no_authorization ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE classtype = 'AU2'
     INTO CORRESPONDING FIELDS OF TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 0 ).

    " enable dcl with authorization via class association (classmaintauthgrp)
    DATA(lo_class_auth) =  cl_cds_test_data=>create_access_control_data(
        i_role_authorizations = VALUE #(
          (
            object         = 'C_TCLA_BKA'
            authorizations = VALUE #(
             (
                VALUE #(
                 (
                    fieldname   = 'KLART'
                    fieldvalues = VALUE #(
                      ( lower_value = 'AU2' )  " User is authorized for CARRID = 'LH' ...
                    )  " Field values
                 )  " KLART
                )
             ) "auth.value
          )
      ) " auth.object C_TCLA_BKA
          (
            object         = 'C_KLAH_BKL'
            authorizations = VALUE #(
             (
                VALUE #(
                 (  fieldname   = 'BGRKL'
                    fieldvalues = VALUE #( ( lower_value = 'ZZZ' ) )
                 )  " BGRKL
                 (  fieldname   = 'ACTVT'
                    fieldvalues = VALUE #( ( lower_value = '03' ) )
                 )  " ACTVT
                )
             ) "auth.value
            )
          )   " auth.object C_KLAH_BKL
      ) " Table of authorization objects
    ).  " CREATE_ACCESS_CONTROL_DATA

    environment->get_access_control_double( )->enable_access_control( i_access_control_data = lo_class_auth ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE classtype = 'AU2'
     INTO CORRESPONDING FIELDS OF TABLE  @act_results.

*    Assertion: all entries where the classmaintauthgrp empty or AAA
*               and classclassfctnauthgrp empty or ZZZ
    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 5 ).

  ENDMETHOD.

METHOD check_maint_dcl.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY,
          act_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY.
    " enable dcl without authorization for the objects -> no result expected
    DATA(acm_data_no_authorization) = cl_cds_test_data=>create_access_control_data( i_role_authorizations = VALUE #( ) ).
    environment->get_access_control_double( )->disable_access_control( ).
    environment->get_access_control_double( )->enable_access_control( i_access_control_data = acm_data_no_authorization ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE classtype = 'AU2'
     INTO CORRESPONDING FIELDS OF TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 0 ).

    DATA(lo_class_auth) =  cl_cds_test_data=>create_access_control_data(
        i_role_authorizations = VALUE #(
          (
            object         = 'C_TCLA_BKA'
            authorizations = VALUE #(
             (
                VALUE #(
                 (
                    fieldname   = 'KLART'
                    fieldvalues = VALUE #(
                      ( lower_value = 'AU2' )  " User is authorized for CARRID = 'LH' ...
                    )  " Field values
                 )  " KLART
                )
             ) "auth.value
          )
      ) " auth.object C_TCLA_BKA
          (
            object         = 'C_KLAH_BKL'
            authorizations = VALUE #(
             (
                VALUE #(
                 (  fieldname   = 'ACTVT'
                    fieldvalues = VALUE #( ( lower_value = '03' ) )
                 )  " ACTVT
                )
             ) "auth.value
            )
          )   " auth.object C_KLAH_BKL
      ) " Table of authorization objects
    ).  " CREATE_ACCESS_CONTROL_DATA

    environment->get_access_control_double( )->enable_access_control( i_access_control_data = lo_class_auth ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE classtype = 'AU2'
     INTO CORRESPONDING FIELDS OF TABLE  @act_results.

*    Assertion: entries where classmaintauthgrp is empty or AAA
*               (and classclassfctnauthgrp is empty)
    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 3 ).
    READ TABLE act_results TRANSPORTING NO FIELDS
    WITH KEY classinternalid = '111'.
    cl_abap_unit_assert=>assert_equals(
      act = sy-subrc
      exp = 0 ).

  ENDMETHOD.

  METHOD check_classif_dcl.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY,
          act_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY.
    " enable dcl without authorization for the objects -> no result expected
    DATA(acm_data_no_authorization) = cl_cds_test_data=>create_access_control_data( i_role_authorizations = VALUE #( ) ).
    environment->get_access_control_double( )->disable_access_control( )."enable_access_control( i_access_control_data = acm_data_no_authorization ).
    environment->get_access_control_double( )->enable_access_control( i_access_control_data = acm_data_no_authorization ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE classtype = 'AU2'
     INTO CORRESPONDING FIELDS OF TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 0 ).

    " enable dcl with authorization via class association (classclassfctnauthgrp)
    DATA(lo_class_auth) =  cl_cds_test_data=>create_access_control_data(
        i_role_authorizations = VALUE #(
          (
            object         = 'C_TCLA_BKA'
            authorizations = VALUE #(
             (
                VALUE #(
                 (
                    fieldname   = 'KLART'
                    fieldvalues = VALUE #(
                      ( lower_value = 'AU2' )  " User is authorized for CARRID = 'LH' ...
                    )  " Field values
                 )  " KLART
                )
             ) "auth.value
          )
      ) " auth.object C_TCLA_BKA
          (
            object         = 'C_KLAH_BKL'
            authorizations = VALUE #(
             (
                VALUE #(
                 (  fieldname   = 'BGRKL'
                    fieldvalues = VALUE #( ( lower_value = 'ZZZ' ) )
                 )  " BGRKL
                 (  fieldname   = 'ACTVT'
                    fieldvalues = VALUE #( ( lower_value = '03' ) )
                 )  " ACTVT
                )
             ) "auth.value
            )
          )   " auth.object C_KLAH_BKL
      ) " Table of authorization objects
    ).  " CREATE_ACCESS_CONTROL_DATA

    environment->get_access_control_double( )->enable_access_control( i_access_control_data = lo_class_auth ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE classtype = 'AU2'
     INTO CORRESPONDING FIELDS OF TABLE  @act_results.

*    Assertion: entries where classclassfctnauthgrp is empty or ZZZ
*               (and classmaintauthgrp is empty)
    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 5 ).
    READ TABLE act_results TRANSPORTING NO FIELDS
    WITH KEY classinternalid = '113'.
    cl_abap_unit_assert=>assert_equals(
      act = sy-subrc
      exp = 0 ).

  ENDMETHOD.

  METHOD check.

    environment->get_access_control_double( )->disable_access_control( ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE clfnobjecttable = 'MARA'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 9 ).

  ENDMETHOD.

  METHOD check_objectid.

    environment->get_access_control_double( )->disable_access_control( ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE clfnobjecttable = 'MARA'
     AND   clfnobjectid    = 'PB_TEST_MAT03H'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 4 ).

  ENDMETHOD.

  METHOD check_empty_objectinternalid.

    environment->get_access_control_double( )->disable_access_control( ).

    SELECT *
     FROM
        i_clfnobjectclass
     WHERE clfnobjecttable = 'MARA'
     AND    clfnobjectinternalid   = '000000000000000000'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 3 ). "single branch and objecttype = 'O'

  ENDMETHOD.

ENDCLASS.

**"* use this source file for your ABAP unit test classes
*"! @testing I_ClfnObjectClass
*CLASS ltc_i_clfnobjectclass DEFINITION FOR TESTING
*  DURATION SHORT
*  RISK LEVEL HARMLESS
*  FINAL.
*
*  PRIVATE SECTION.
*    TYPES:
*      ltt_i_objectclass           TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY.
*
*    CLASS-DATA:
*      environment TYPE REF TO if_cds_test_environment.
*
*    CLASS-METHODS:
*      class_setup,
*      class_teardown.
*
*    DATA:
*      act_results TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY.
*
*    METHODS:
*      setup,
*      check                         FOR TESTING,
*      check_objectid                FOR TESTING,
*      check_empty_objectinternalid  FOR TESTING,
*      full_authorization            FOR TESTING,
*      check_clfn_dcl                FOR TESTING,
*      check_classtype_clfn_dcl      FOR TESTING.
*
*    METHODS:
*      read_cds
*        RETURNING
*          VALUE(rt_result) TYPE ltt_i_objectclass,
*      get_authorization_object
*        IMPORTING
*          iv_classtype      TYPE string
*          iv_activity       TYPE string
*          iv_clfn_auth_grp  TYPE string
*        RETURNING
*          VALUE(ro_result)  TYPE REF TO if_cds_access_control_data.
*
*ENDCLASS.
*
*CLASS ltc_i_clfnobjectclass IMPLEMENTATION.
*  METHOD class_setup.
*    environment = cl_cds_test_environment=>create(
*      i_for_entity      = 'I_ClfnObjectClass'
*      test_associations = abap_true
*    ).
*  ENDMETHOD.
*
*  METHOD class_teardown.
*    environment->destroy( ).
*  ENDMETHOD.
*
*  METHOD setup.
*
*    DATA: lt_objectheader     TYPE STANDARD TABLE OF p_clfnobjectheader WITH EMPTY KEY,
*          lt_objectclass      TYPE STANDARD TABLE OF i_clfnobjectclassbasic WITH EMPTY KEY,
*          lo_objectheader     TYPE REF TO if_cds_test_data,
*          lo_objectclass      TYPE REF TO if_cds_test_data,
*          lt_class            TYPE STANDARD TABLE OF i_clfnclass WITH EMPTY KEY,
*          lo_class            TYPE REF TO if_cds_test_data.
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
*      ( classtype       = 'AU2'
*        clfnobjecttype  = 'O'
*        clfnobjecttable = 'MARA'
*        clfnobjectid    = 'PB_TEST_MAT03G'
*        clfnobjectinternalid = '000000000001124630'
*        objekp          = '000000000001124630' )
*    ).
*    lo_objectheader = cl_cds_test_data=>create( i_data = lt_objectheader ).
*    DATA(lo_classtype_stub) = environment->get_double( i_name = 'P_ClfnObjectHeader' ).
*    lo_classtype_stub->insert( lo_objectheader ).
*
*    lt_objectclass = VALUE #(
*      ( clfnobjectid = 'PB_TEST_MAT03E'
*        classinternalid = '101'
*        classtype = 'AU0'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '10'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = 'PB_TEST_MAT03F'
*        classinternalid = '102'
*        classtype = 'AU0'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '10'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = 'PB_TEST_MAT03F'
*        classinternalid = '103'
*        classtype = 'AU0'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '20'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '103'
*        classinternalid = '105'
*        classtype = 'AU1'
*        clfnobjecttype = 'K'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '10'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '104'
*        classinternalid = '105'
*        classtype = 'AU1'
*        clfnobjecttype = 'K'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '20'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      "multi-object enabled class types
*      ( clfnobjectid = '000000000001124560'
*        classinternalid = '110'
*        classtype = 'AU1'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '10'
*        changenumber = 'AU0101'
*        validitystartdate = '20180101'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124629'
*        classinternalid = '111'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '10'
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124629'
*        classinternalid = '112'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '20'
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124629'
*        classinternalid = '113'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '20'
*        isdeleted   = abap_true
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124630'
*        classinternalid = '114'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '20'
*        isdeleted   = abap_true
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*      ( clfnobjectid = '000000000001124630'
*        classinternalid = '115'
*        classtype = 'AU2'
*        clfnobjecttype = 'O'
*        timeintervalnumber = '0000'
*        clfnstatus = '1'
*        classpositionnumber = '20'
*        isdeleted   = abap_true
*        changenumber = 'AU0102'
*        validitystartdate = '20180201'
*        validityenddate = '99991231' )
*    ).
*    lo_objectclass  = cl_cds_test_data=>create( i_data = lt_objectclass  ).
*    DATA(lo_objectclass_stub) = environment->get_double( i_name = 'I_ClfnObjectClassBasic' ).
*    lo_objectclass_stub->insert( lo_objectclass ).
*
*    lt_class = VALUE #(
*      ( classinternalid       = '101'
*        class                 = '101'
*        classtype             = 'AU0'
*        classclassfctnauthgrp = 'YYY'
*        validitystartdate     = '20180201'
*        validityenddate       = '99991231' )
*      ( classinternalid       = '111'
*        class                 = '111'
*        classtype             = 'AU2'
*        classclassfctnauthgrp = 'YYY'
*        validitystartdate     = '20180201'
*        validityenddate       = '99991231' )
*      ( classinternalid       = '112'
*        class                 = '112'
*        classtype             = 'AU2'
*        classclassfctnauthgrp = ''
*        validitystartdate     = '20180201'
*        validityenddate       = '99991231' )
*      ( classinternalid       = '113'
*        class                 = '113'
*        classtype             = 'AU2'
*        classclassfctnauthgrp = 'ZZZ'
*        validitystartdate     = '20180201'
*        validityenddate       = '99991231' )
*      ( classinternalid       = '114'
*        class                 = '114'
*        classtype             = 'AU2'
*        classclassfctnauthgrp = ''
*        validitystartdate     = '20180201'
*        validityenddate       = '99991231' )
*      ( classinternalid       = '115'
*        class                 = '115'
*        classtype             = 'AU2'
*        classclassfctnauthgrp = 'ZZZ'
*        validitystartdate     = '20180201'
*        validityenddate       = '99991231' )
*    ).
*    lo_class = cl_cds_test_data=>create( i_data = lt_class ).
*    DATA(lo_class_stub) = environment->get_double( i_name = 'I_ClfnClass' ).
*    lo_class_stub->insert( lo_class ).
*
*  ENDMETHOD.
*  METHOD full_authorization.
*
*    " Given: I have full authorization.
*    DATA(lo_auth) = me->get_authorization_object(
*      iv_classtype      = '*'
*      iv_activity       = '*'
*      iv_clfn_auth_grp  = '*'
*    ).
*
*    environment->get_access_control_double( )->enable_access_control( lo_auth ).
*
*    " When: I read from the view.
*    DATA(lt_result) = me->read_cds( ).
*
*    " Then: I should have get all data.
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( lt_result )
*      exp = 6
*    ).
*
*  ENDMETHOD.
*
*  METHOD check_clfn_dcl.
*
*    " Given: I have full authorization.
*    DATA(lo_auth) = me->get_authorization_object(
*      iv_classtype      = '*'
*      iv_activity       = '03'
*      iv_clfn_auth_grp  = 'YYY'
*    ).
*
*    environment->get_access_control_double( )->enable_access_control( lo_auth ).
*
*    " When: I read from the view.
*    DATA(lt_result) = me->read_cds( ).
*
*    " Then: I should have get all data.
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( lt_result )
*      exp = 4
*    ).
*
*  ENDMETHOD.
*
*  METHOD check_classtype_clfn_dcl.
*    " Given: I have full authorization.
*    DATA(lo_auth) = me->get_authorization_object(
*      iv_classtype      = 'AU0'
*      iv_activity       = '03'
*      iv_clfn_auth_grp  = 'YYY'
*    ).
*
*    environment->get_access_control_double( )->enable_access_control( lo_auth ).
*
*    " When: I read from the view.
*    DATA(lt_result) = me->read_cds( ).
*
*    " Then: I should have get all data.
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( lt_result )
*      exp = 1
*    ).
*
*  ENDMETHOD.
*
*  METHOD check.
*
*    environment->get_access_control_double( )->disable_access_control( ).
*
*    SELECT *
*     FROM
*        i_clfnobjectclass
*     WHERE clfnobjecttable = 'MARA'
*     INTO TABLE @act_results.
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( act_results )
*      exp = 9 ).
*
*  ENDMETHOD.
*
*  METHOD check_objectid.
*
*    environment->get_access_control_double( )->disable_access_control( ).
*
*    SELECT *
*     FROM
*        i_clfnobjectclass
*     WHERE clfnobjecttable = 'MARA'
*     AND   clfnobjectid    = 'PB_TEST_MAT03H'
*     INTO TABLE @act_results.
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( act_results )
*      exp = 4 ).
*
*  ENDMETHOD.
*
*  METHOD check_empty_objectinternalid.
*
*    environment->get_access_control_double( )->disable_access_control( ).
*
*    SELECT *
*     FROM
*        i_clfnobjectclass
*     WHERE clfnobjecttable = 'MARA'
*      AND    clfnobjectinternalid   IS NOT INITIAL
*     INTO TABLE @act_results.
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( act_results )
*      exp = 6 ). "multi branch and objecttype = 'O'
*
*  ENDMETHOD.
*
*  METHOD read_cds.
*
*    SELECT * FROM i_clfnobjectclass
*      INTO TABLE @rt_result.
*
*  ENDMETHOD.
*
*  METHOD get_authorization_object.
*
*    ro_result = cl_cds_test_data=>create_access_control_data(
*      VALUE #(
*        ( object         = 'C_TCLA_BKA'  "class type
*          authorizations = VALUE #(
*            ( VALUE #(
*                ( fieldname   = 'KLART'
*                  fieldvalues = VALUE #(
*                    ( lower_value = iv_classtype ) ) ) ) ) ) )
*        ( object         = 'C_KLAH_BKL'  "classification authg.roup
*          authorizations = VALUE #(
*            ( VALUE #(
*                ( fieldname   = 'ACTVT'
*                  fieldvalues = VALUE #(
*                    ( lower_value = iv_activity ) ) )
*                ( fieldname   = 'BGRKL'
*                  fieldvalues = VALUE #(
*                    ( lower_value = iv_clfn_auth_grp ) ) ) ) ) ) )
*      )
*    ).
*
*  ENDMETHOD.
*
*ENDCLASS.