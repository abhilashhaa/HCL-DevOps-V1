*"* use this source file for your ABAP unit test classes
"! @testing I_ClfnCharcReference
CLASS ltc_i_clfncharcreference DEFINITION FOR TESTING
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
      act_results   TYPE STANDARD TABLE OF i_clfncharcreference WITH EMPTY KEY.

    METHODS:
      setup,
      check FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfncharcreference IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnCharcReference' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_cabn  TYPE STANDARD TABLE OF cabn  WITH EMPTY KEY,
          lt_cabnz TYPE STANDARD TABLE OF cabnz WITH EMPTY KEY,
          lo_cabn  TYPE REF TO if_cds_test_data,
          lo_cabnz TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_cabn = VALUE #(
        ( mandt = sy-mandt atinn = '00005190' attab = 'TCLA'  atfel = 'klart' datuv = '19000101' datub = '99991231' )
        ( mandt = sy-mandt atinn = '00005191' attab = 'TCLA'  atfel = 'klart' datuv = '19000101' datub = '99991231' )
        ( mandt = sy-mandt atinn = '00005192' attab = 'TCLA'  atfel = 'klart' datuv = '19000101' datub = '99991231' )
        ( mandt = sy-mandt atinn = '00005193' attab = 'TCLA'  atfel = 'klart' datuv = '19000101' datub = '99991231' )
    ).

    lo_cabn = cl_cds_test_data=>create( i_data = lt_cabn ).
    DATA(lo_cabn_stub) = environment->get_double( i_name = 'cabn' ).
    lo_cabn_stub->insert( lo_cabn ).

    lt_cabnz = VALUE #(
        ( mandt = sy-mandt atinn = '00005190' attab = 'TCLA'  atfel = 'klart' )
        ( mandt = sy-mandt atinn = '00005190' attab = 'TCLAO' atfel = 'klart' )
        ( mandt = sy-mandt atinn = '00005192' attab = 'TCLA'  atfel = 'klart' )
        ( mandt = sy-mandt atinn = '00005192' attab = 'TCLAO' atfel = 'klart' )
    ).

    lo_cabnz = cl_cds_test_data=>create( i_data = lt_cabnz ).
    DATA(lo_cabnz_stub) = environment->get_double( i_name = 'cabnz' ).
    lo_cabnz_stub->insert( lo_cabnz ).

  ENDMETHOD.

  METHOD check.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfncharcreference WITH EMPTY KEY.

    SELECT * FROM i_clfncharcreference WHERE charcinternalid = '00005190' OR charcinternalid = '00005193' INTO TABLE @act_results.

    exp_results = VALUE #(
        ( charcinternalid = '00005190' charcreferencetable = 'TCLA'  charcreferencetablefield = 'klart' )
        ( charcinternalid = '00005190' charcreferencetable = 'TCLAO' charcreferencetablefield = 'klart' )
        ( charcinternalid = '00005193' charcreferencetable = 'TCLA'  charcreferencetablefield = 'klart' )
    ).

    SORT exp_results ASCENDING BY charcinternalid charcreferencetable charcreferencetablefield.
    SORT act_results ASCENDING BY charcinternalid charcreferencetable charcreferencetablefield.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

ENDCLASS.