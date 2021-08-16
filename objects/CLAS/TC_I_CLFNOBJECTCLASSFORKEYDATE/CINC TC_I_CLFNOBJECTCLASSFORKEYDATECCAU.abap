

*"* use this source file for your ABAP unit test classes
"! @testing I_ClfnObjectClassForKeyDate
CLASS ltc_i_clfnobjclassforkeydate DEFINITION FOR TESTING
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
      act_results TYPE STANDARD TABLE OF i_clfnobjectclassforkeydate WITH EMPTY KEY.

    METHODS:
      setup,
      check_keydate_20180101 FOR TESTING,
      check_keydate_20180201 FOR TESTING,
      check_objectid_del  FOR TESTING,
      check_objectid  FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfnobjclassforkeydate IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnObjectClassForKeyDate' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_objectclass TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY,
          lo_objectclass TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_objectclass = VALUE #(
      ( clfnobjectid = 'PB_TEST_MAT03E'
        clfnobjecttable = 'MARA'
        classinternalid = '101'
        classtype = 'AU1'
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
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        changenumber = 'AU0101'
        validitystartdate = '20180101'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjecttable = 'MARA'
        classinternalid = '110'
        clfnobjectinternalid = '000000000001124560'
        classtype = 'AU1'
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
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjecttable = 'MARA'
        classinternalid = '30196'
        clfnobjectinternalid = '000000000001124629'
        classtype = 'AU2'
        timeintervalnumber = '0000'
        clfnstatus = '1'
        classpositionnumber = '20'
        changenumber = 'AU0102'
        validitystartdate = '20180101'
        validityenddate = '20180131' )
      ( clfnobjectid = 'PB_TEST_MAT03H'
        clfnobjecttable = 'MARA'
        classinternalid = '30196'
        clfnobjectinternalid = '000000000001124629'
        classtype = 'AU2'
        timeintervalnumber = '0001'
        clfnstatus = '1'
        classpositionnumber = '20'
        isdeleted   = abap_true
        changenumber = 'AU0102'
        validitystartdate = '20180201'
        validityenddate = '99991231' )
    ).
    lo_objectclass = cl_cds_test_data=>create( i_data = lt_objectclass ).
    DATA(lo_objectclass_stub) = environment->get_double( i_name = 'I_ClfnObjectClass' ).
    lo_objectclass_stub->insert( lo_objectclass ).

  ENDMETHOD.

  METHOD check_keydate_20180101.

    SELECT * FROM i_clfnobjectclassforkeydate( p_keydate = '20180101' )
     WHERE clfnobjecttable = 'MARA'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 5 ).

  ENDMETHOD.

  METHOD check_keydate_20180201.

    SELECT * FROM i_clfnobjectclassforkeydate( p_keydate = '20180201' )
     WHERE clfnobjecttable = 'MARA'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 6 ).

  ENDMETHOD.

  METHOD check_objectid.

    SELECT * FROM i_clfnobjectclassforkeydate( p_keydate = '20180101' )
     WHERE clfnobjecttable = 'MARA'
     AND   clfnobjectid    = 'PB_TEST_MAT03H'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 2 ).

  ENDMETHOD.

  METHOD check_objectid_del.

    SELECT * FROM i_clfnobjectclassforkeydate( p_keydate = '20180201' )
     WHERE clfnobjecttable = 'MARA'
     AND   clfnobjectid    = 'PB_TEST_MAT03H'
     INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 3 ).

  ENDMETHOD.

ENDCLASS.


CLASS lth_test_data DEFINITION
    FOR TESTING.

  PUBLIC SECTION.

    CLASS-DATA:
      gs_class_001       TYPE i_clfnclassforkeydate,
      gs_class_002       TYPE i_clfnclassforkeydate,
      gs_class_003       TYPE i_clfnclassforkeydate,
      gs_class_004       TYPE i_clfnclassforkeydate,
      gs_objectclass_001 TYPE i_clfnobjectclass,
      gs_objectclass_002 TYPE i_clfnobjectclass,
      gs_objectclass_003 TYPE i_clfnobjectclass,
      gs_objectclass_004 TYPE i_clfnobjectclass.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_test_data IMPLEMENTATION.

  METHOD class_constructor.

    gs_class_001 = VALUE #(
      classinternalid       = '1'
      class                 = 'CLASS_1'
      classtype             = 'UT1'
      classmaintauthgrp     = 'MG1'
      classclassfctnauthgrp = ''
      validitystartdate     = if_ngc_c=>gc_date_min
      validityenddate       = if_ngc_c=>gc_date_max
    ).

    gs_class_002 = VALUE #(
      classinternalid       = '2'
      class                 = 'CLASS_2'
      classtype             = 'UT1'
      classmaintauthgrp     = 'MG2'
      classclassfctnauthgrp = 'CG1'
      validitystartdate     = if_ngc_c=>gc_date_min
      validityenddate       = if_ngc_c=>gc_date_max
    ).

    gs_class_003 = VALUE #(
      classinternalid       = '3'
      class                 = 'CLASS_3'
      classtype             = 'UT1'
      classmaintauthgrp     = 'MG3'
      classclassfctnauthgrp = 'CG0'
      validitystartdate     = if_ngc_c=>gc_date_min
      validityenddate       = if_ngc_c=>gc_date_max
    ).

    gs_class_004 = VALUE #(
      classinternalid       = '4'
      class                 = 'CLASS_4'
      classtype             = 'UT2'
      classmaintauthgrp     = 'MG2'
      classclassfctnauthgrp = 'CG0'
      validitystartdate     = if_ngc_c=>gc_date_min
      validityenddate       = if_ngc_c=>gc_date_max
    ).

    gs_objectclass_001 = VALUE #(
      clfnobjectid      = '1000'
      clfnobjecttable   = 'OBJT'
      classinternalid   = '1'
      classtype         = 'UT1'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max
    ).

    gs_objectclass_002 = VALUE #(
      clfnobjectid    = '1000'
      clfnobjecttable = 'OBJT'
      classinternalid = '2'
      classtype       = 'UT1'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max
    ).

    gs_objectclass_003 = VALUE #(
      clfnobjectid    = '1000'
      clfnobjecttable = 'OBJT'
      classinternalid = '3'
      classtype       = 'UT1'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max
    ).

    gs_objectclass_004 = VALUE #(
      clfnobjectid    = '1000'
      clfnobjecttable = 'OBJT'
      classinternalid = '4'
      classtype       = 'UT2'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max
    ).

  ENDMETHOD.

ENDCLASS.

"! @testing I_ClfnObjectClassForKeyDate
CLASS ltc_i_clfnobjclforkeydate_auth DEFINITION
    FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS
    FINAL.

  PRIVATE SECTION.

    TYPES:
      ltt_i_classforkeydate       TYPE STANDARD TABLE OF i_clfnclassforkeydate WITH EMPTY KEY,
      ltt_i_objectclassforkeydate TYPE STANDARD TABLE OF i_clfnobjectclassforkeydate WITH EMPTY KEY,
      ltt_i_objectclass           TYPE STANDARD TABLE OF i_clfnobjectclass WITH EMPTY KEY.

    CLASS-DATA:
      go_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup.

    METHODS:
      no_authorization    FOR TESTING,
      full_authorization  FOR TESTING,
      classtype_restrict  FOR TESTING,
      activity_restrict   FOR TESTING,
      maint_auth_group_restrict FOR TESTING,
      clfn_auth_group_restrict FOR TESTING,
      both_auth_group_restrict FOR TESTING,
      classtype_and_group FOR TESTING.

    METHODS:
      read_cds
        RETURNING
          VALUE(rt_result) TYPE ltt_i_objectclassforkeydate,
      get_authorization_object
        IMPORTING
          iv_classtype      TYPE string
          iv_activity       TYPE string
          iv_maint_auth_grp TYPE string
          iv_clfn_auth_grp  TYPE string
        RETURNING
          VALUE(ro_result)  TYPE REF TO if_cds_access_control_data.

ENDCLASS.

CLASS ltc_i_clfnobjclforkeydate_auth IMPLEMENTATION.

  METHOD class_setup.

    go_environment = cl_cds_test_environment=>create(
      i_for_entity      = 'I_ClfnObjectClassForKeyDate'
      test_associations = abap_true
    ).

  ENDMETHOD.

  METHOD class_teardown.

    go_environment->destroy( ).

  ENDMETHOD.

  METHOD setup.

    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).

    DATA(lt_class) = VALUE ltt_i_classforkeydate(
      ( lth_test_data=>gs_class_001 )
      ( lth_test_data=>gs_class_002 )
      ( lth_test_data=>gs_class_003 )
      ( lth_test_data=>gs_class_004 )
    ).
    go_environment->insert_test_data(
      i_data             = lt_class
      i_parameter_values = VALUE #(
        ( parameter_name  = 'P_KeyDate'
          parameter_value = sy-datum ) )
    ).

    DATA(lt_objectclass) = VALUE ltt_i_objectclass(
      ( lth_test_data=>gs_objectclass_001 )
      ( lth_test_data=>gs_objectclass_002 )
      ( lth_test_data=>gs_objectclass_003 )
      ( lth_test_data=>gs_objectclass_004 )
    ).
    go_environment->insert_test_data( lt_objectclass ).

  ENDMETHOD.

  METHOD no_authorization.

    " Given: I don't have authorization to display any.
    DATA(lo_no_auth) = cl_cds_test_data=>create_access_control_data( VALUE #( ) ).

    go_environment->get_access_control_double( )->enable_access_control( lo_no_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have an empty result.
    cl_abap_unit_assert=>assert_initial( lt_result ).

  ENDMETHOD.

  METHOD full_authorization.

    " Given: I have full authorization.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_activity       = '*'
      iv_maint_auth_grp = '*'
      iv_clfn_auth_grp  = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have get all data.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 4
    ).

  ENDMETHOD.

  METHOD classtype_restrict.

    " Given: I have a restriction to read classtype UT1 only.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = 'UT1'
      iv_activity       = '*'
      iv_maint_auth_grp = '*'
      iv_clfn_auth_grp  = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have get data with class type UT1.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 3
    ).

  ENDMETHOD.

  METHOD activity_restrict.

    " Given: I have a restriction for activity.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_activity       = '02'
      iv_maint_auth_grp = '*'
      iv_clfn_auth_grp  = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have an empty result.
    cl_abap_unit_assert=>assert_initial( lt_result ).

  ENDMETHOD.


  METHOD maint_auth_group_restrict.

    " Given: I have a restriction to maint. auth.group MG1.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_activity       = '03'
      iv_maint_auth_grp = 'MG1'
      iv_clfn_auth_grp  = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have get data where class auth.group MG1 is set
    " and where the class auth.group is initial (1+0=1).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1
    ).

  ENDMETHOD.

  METHOD clfn_auth_group_restrict.

    " Given: I have a restriction to clfn. auth.group CG0.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_activity       = '03'
      iv_maint_auth_grp = '*'
      iv_clfn_auth_grp  = 'CG0'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have get data where clfn. auth.group CG0 is set
    " and where the clfn. auth.group is initial (2+1=3).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 3
    ).

  ENDMETHOD.

  METHOD both_auth_group_restrict.

    " Given: I have a restriction to clfn. auth.group CG0
    " and to maint. auth.group MG2.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_activity       = '03'
      iv_maint_auth_grp = 'MG2'
      iv_clfn_auth_grp  = 'CG0'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have get data where clfn. auth.group CG0 is set
    " and where the clfn. auth.group MG2 is set OR one of them is set and
    " the other initial (1+0=1).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1
    ).

  ENDMETHOD.

  METHOD classtype_and_group.

    " Given: I have a restriction to read classtype UT2
    " and clfn. auth. group CG0.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = 'UT2'
      iv_activity       = '*'
      iv_maint_auth_grp = '*'
      iv_clfn_auth_grp  = 'CG0'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have get data with class type UT2
    " and clfn. auth. group CG0.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1
    ).

  ENDMETHOD.


  METHOD read_cds.

    SELECT * FROM i_clfnobjectclassforkeydate
      INTO TABLE @rt_result.

  ENDMETHOD.

  METHOD get_authorization_object.

    ro_result = cl_cds_test_data=>create_access_control_data(
      VALUE #(
        ( object         = 'C_TCLA_BKA'  "class type
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'KLART'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_classtype ) ) ) ) ) ) )
        ( object         = 'C_KLAH_BKP'  "maintenance auth.group
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'ACTVT'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_activity ) ) )
                ( fieldname   = 'BGRKP'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_maint_auth_grp ) ) ) ) ) ) )
        ( object         = 'C_KLAH_BKL'  "classification authg.roup
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'ACTVT'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_activity ) ) )
                ( fieldname   = 'BGRKL'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_clfn_auth_grp ) ) ) ) ) ) )
      )
    ).

  ENDMETHOD.

ENDCLASS.