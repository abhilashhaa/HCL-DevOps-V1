*"* use this source file for your ABAP unit test classes
"! @testing I_ClfnClassSuperiorForKeyDate
CLASS ltc_i_clfnclasssuperiorforkeyd DEFINITION FOR TESTING
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
      act_results   TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY.

    METHODS:
      setup,
      hierarchy_check_current_1  FOR TESTING,
      hierarchy_check_current_2  FOR TESTING,
      hierarchy_check_current_3  FOR TESTING,
      hierarchy_check_161001_1   FOR TESTING,
      hierarchy_check_161001_2   FOR TESTING,
      hierarchy_check_161001_3   FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfnclasssuperiorforkeyd IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnClassSuperiorForKeyDate' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_class TYPE STANDARD TABLE OF i_clfnclass WITH EMPTY KEY,
          lt_gidx  TYPE STANDARD TABLE OF i_clfnclasshierarchy WITH EMPTY KEY,
          lo_class TYPE REF TO if_cds_test_data,
          lo_gidx  TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_gidx = VALUE #(
     ( descendantclassinternalid = '1000000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2000000000' classtype = '001' ancestorclassinternalid = '2000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1100000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1100000000' classtype = '001' ancestorclassinternalid = '1100000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1200000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1200000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1300000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1300000000' classtype = '001' ancestorclassinternalid = '1300000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1110000000' classtype = '001' ancestorclassinternalid = '1100000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1110000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1110000000' classtype = '001' ancestorclassinternalid = '2000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1110000000' classtype = '001' ancestorclassinternalid = '1110000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '1100000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '1110000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '2000000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '1210000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '1212000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1111000000' classtype = '001' ancestorclassinternalid = '1111000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1120000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1120000000' classtype = '001' ancestorclassinternalid = '1100000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1120000000' classtype = '001' ancestorclassinternalid = '1120000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1130000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1130000000' classtype = '001' ancestorclassinternalid = '1100000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1130000000' classtype = '001' ancestorclassinternalid = '1130000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1210000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1210000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1210000000' classtype = '001' ancestorclassinternalid = '1210000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1211000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1211000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1211000000' classtype = '001' ancestorclassinternalid = '1210000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1211000000' classtype = '001' ancestorclassinternalid = '1211000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1212000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1212000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1212000000' classtype = '001' ancestorclassinternalid = '1210000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1212000000' classtype = '001' ancestorclassinternalid = '1212000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1213000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1213000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1213000000' classtype = '001' ancestorclassinternalid = '1210000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1213000000' classtype = '001' ancestorclassinternalid = '1213000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1220000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1220000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1220000000' classtype = '001' ancestorclassinternalid = '1220000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1221000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1221000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1221000000' classtype = '001' ancestorclassinternalid = '1220000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1221000000' classtype = '001' ancestorclassinternalid = '1221000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1310000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1310000000' classtype = '001' ancestorclassinternalid = '1300000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1310000000' classtype = '001' ancestorclassinternalid = '1310000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1310000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1311000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20150101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1311000000' classtype = '001' ancestorclassinternalid = '1300000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1311000000' classtype = '001' ancestorclassinternalid = '1310000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1311000000' classtype = '001' ancestorclassinternalid = '1311000000' validitystartdate = '20150101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1311000000' classtype = '001' ancestorclassinternalid = '1220000000' validitystartdate = '20161201' validityenddate = '99991231' )
     ( descendantclassinternalid = '1311000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1312000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1312000000' classtype = '001' ancestorclassinternalid = '1300000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1312000000' classtype = '001' ancestorclassinternalid = '1310000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '1312000000' classtype = '001' ancestorclassinternalid = '1312000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2100000000' classtype = '001' ancestorclassinternalid = '2000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2100000000' classtype = '001' ancestorclassinternalid = '2100000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '2000000000' validitystartdate = '20150101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '2100000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '2110000000' validitystartdate = '20160601' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '1000000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '1100000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '1130000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '1300000000' validitystartdate = '20170101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '1310000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '1312000000' validitystartdate = '20160101' validityenddate = '99991231' )
     ( descendantclassinternalid = '2110000000' classtype = '001' ancestorclassinternalid = '1200000000' validitystartdate = '20170101' validityenddate = '99991231' )
    ).

    lo_gidx = cl_cds_test_data=>create( i_data = lt_gidx ).
    DATA(lo_gidx_stub) = environment->get_double( i_name = 'i_clfnClassHierarchy' ).
    lo_gidx_stub->insert( lo_gidx ).

    lt_class = VALUE #(
       ( classinternalid = '1000000000' classtype = '001' class = 'ST_H00A' classstatus = '1' validitystartdate = '20150101' validityenddate = '99991231' )
       ( classinternalid = '2000000000' classtype = '001' class = 'ST_H00B' classstatus = '1' validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '1100000000' classtype = '001' class = 'ST_H001' classstatus = '1' validitystartdate = '20160101' validityenddate = '99991231' )
       ( classinternalid = '1200000000' classtype = '001' class = 'ST_H002' classstatus = '1' validitystartdate = '20160101' validityenddate = '99991231' )
       ( classinternalid = '1300000000' classtype = '001' class = 'ST_H003' classstatus = '1' validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '1110000000' classtype = '001' class = 'ST_H004' classstatus = '1' validitystartdate = '20150101' validityenddate = '99991231' )
       ( classinternalid = '1120000000' classtype = '001' class = 'ST_H005' classstatus = '1' validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '1130000000' classtype = '001' class = 'ST_H006' classstatus = '1' validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '1111000000' classtype = '001' class = 'ST_H007' classstatus = '1' validitystartdate = '20150101' validityenddate = '99991231' )
       ( classinternalid = '1210000000' classtype = '001' class = 'ST_H008' classstatus = '1' validitystartdate = '20160101' validityenddate = '99991231' )
       ( classinternalid = '1220000000' classtype = '001' class = 'ST_H009' classstatus = '1' validitystartdate = '20150101' validityenddate = '99991231' )
       ( classinternalid = '1211000000' classtype = '001' class = 'ST_H010' classstatus = '1' validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '1212000000' classtype = '001' class = 'ST_H011' classstatus = '1' validitystartdate = '20150101' validityenddate = '99991231' )
       ( classinternalid = '1213000000' classtype = '001' class = 'ST_H012' classstatus = '1' validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '1310000000' classtype = '001' class = 'ST_H013' classstatus = '1' validitystartdate = '20150101' validityenddate = '99991231' )
       ( classinternalid = '1311000000' classtype = '001' class = 'ST_H014' classstatus = '1' validitystartdate = '20150101' validityenddate = '99991231' )
       ( classinternalid = '1312000000' classtype = '001' class = 'ST_H015' classstatus = '1' validitystartdate = '20160101' validityenddate = '99991231' )
       ( classinternalid = '2100000000' classtype = '001' class = 'ST_H016' classstatus = '1' validitystartdate = '20160101' validityenddate = '99991231' )
       ( classinternalid = '2110000000' classtype = '001' class = 'ST_H017' classstatus = '1' validitystartdate = '20160601' validityenddate = '99991231' )
    ).

    lo_class = cl_cds_test_data=>create( i_data = lt_class ).
    DATA(lo_class_stub) = environment->get_double( i_name = 'I_ClfnClass' ).
    lo_class_stub->insert( lo_class ).

  ENDMETHOD.

  METHOD hierarchy_check_current_1.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasssuperiorforkeydate WHERE class = 'ST_H007' INTO TABLE @act_results.

    exp_results = VALUE #(
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H00A' ancestorclassinternalid = '1000000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H001' ancestorclassinternalid = '1100000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H004' ancestorclassinternalid = '1110000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H00B' ancestorclassinternalid = '2000000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H002' ancestorclassinternalid = '1200000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H008' ancestorclassinternalid = '1210000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H011' ancestorclassinternalid = '1212000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H007' ancestorclassinternalid = '1111000000'  )
    ).

    SORT act_results BY ancestorclass ASCENDING.
    SORT exp_results BY ancestorclass ASCENDING.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD hierarchy_check_current_2.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasssuperiorforkeydate WHERE class = 'ST_H014' INTO TABLE @act_results.

    exp_results = VALUE #(
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H00A' ancestorclassinternalid = '1000000000'  )
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H003' ancestorclassinternalid = '1300000000'  )
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H013' ancestorclassinternalid = '1310000000'  )
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H014' ancestorclassinternalid = '1311000000'  )
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H009' ancestorclassinternalid = '1220000000'  )
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H002' ancestorclassinternalid = '1200000000'  )
    ).

    SORT act_results BY ancestorclass ASCENDING.
    SORT exp_results BY ancestorclass ASCENDING.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD hierarchy_check_current_3.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasssuperiorforkeydate WHERE class = 'ST_H017' INTO TABLE @act_results.

    exp_results = VALUE #(
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H00B' ancestorclassinternalid = '2000000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H016' ancestorclassinternalid = '2100000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H017' ancestorclassinternalid = '2110000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H00A' ancestorclassinternalid = '1000000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H001' ancestorclassinternalid = '1100000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H006' ancestorclassinternalid = '1130000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H003' ancestorclassinternalid = '1300000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H013' ancestorclassinternalid = '1310000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H015' ancestorclassinternalid = '1312000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H002' ancestorclassinternalid = '1200000000'  )
    ).

    SORT act_results BY ancestorclass ASCENDING.
    SORT exp_results BY ancestorclass ASCENDING.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD hierarchy_check_161001_1.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasssuperiorforkeydate( p_keydate = '20161001' ) WHERE class = 'ST_H007' INTO TABLE @act_results.

    exp_results = VALUE #(
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H00A' ancestorclassinternalid = '1000000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H004' ancestorclassinternalid = '1110000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H008' ancestorclassinternalid = '1210000000'  )
      ( classinternalid = '1111000000' class = 'ST_H007' classtype = '001' ancestorclass = 'ST_H007' ancestorclassinternalid = '1111000000'  )
    ).

    SORT act_results BY ancestorclass ASCENDING.
    SORT exp_results BY ancestorclass ASCENDING.

    cl_abap_unit_assert=>assert_equals(
     act = act_results
     exp = exp_results ).
  ENDMETHOD.

  METHOD hierarchy_check_161001_2.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasssuperiorforkeydate( p_keydate = '20161001' ) WHERE class = 'ST_H014' INTO TABLE @act_results.

    exp_results = VALUE #(
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H00A' ancestorclassinternalid = '1000000000'  )
      ( classinternalid = '1311000000' class = 'ST_H014' classtype = '001' ancestorclass = 'ST_H014' ancestorclassinternalid = '1311000000'  )
    ).

    SORT act_results BY ancestorclass ASCENDING.
    SORT exp_results BY ancestorclass ASCENDING.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD hierarchy_check_161001_3.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasssuperiorforkeydate( p_keydate = '20161001' ) WHERE class = 'ST_H017' INTO TABLE @act_results.

    exp_results = VALUE #(
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H017' ancestorclassinternalid = '2110000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H013' ancestorclassinternalid = '1310000000'  )
      ( classinternalid = '2110000000' class = 'ST_H017' classtype = '001' ancestorclass = 'ST_H015' ancestorclassinternalid = '1312000000'  )
    ).

    SORT act_results BY ancestorclass ASCENDING.
    SORT exp_results BY ancestorclass ASCENDING.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

ENDCLASS.