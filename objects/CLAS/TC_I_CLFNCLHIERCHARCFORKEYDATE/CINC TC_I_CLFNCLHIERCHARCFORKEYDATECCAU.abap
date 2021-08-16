*"* use this source file for your ABAP unit test classes
"! @testing I_ClfnClassHierCharcForKeyDate
CLASS ltc_i_clfnclshcharcforkeydte DEFINITION FOR TESTING
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
      act_results   TYPE STANDARD TABLE OF i_clfnclasshiercharcforkeydate WITH EMPTY KEY.

    METHODS:
      setup,
      check FOR TESTING,
      check_wo_validity FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfnclshcharcforkeydte IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnClassHierCharcForKeyDate' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_charc         TYPE STANDARD TABLE OF i_clfncharcbasic WITH EMPTY KEY,
          lt_alloc         TYPE STANDARD TABLE OF i_clfnclasscharcbasic WITH EMPTY KEY,
          lt_classsuperior TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH EMPTY KEY,
          lt_param_vals    TYPE if_cds_parameter_values_config=>ty_parameter_value_pairs,
          lo_classsuperior TYPE REF TO if_cds_test_data,
          lo_charc         TYPE REF TO if_cds_test_data,
          lo_alloc         TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_param_vals = VALUE #( ( parameter_name = `P_KeyDate` parameter_value = '20170210' ) ).

    lt_charc = VALUE #(
        ( characteristic = 'PB_CH_0002' charcinternalid = '00000002' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0001' charcinternalid = '00000001' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0003' charcinternalid = '00000003' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0004' charcinternalid = '00000004' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0005' charcinternalid = '00000005' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0006' charcinternalid = '00000006' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0007' charcinternalid = '00000007' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0008' charcinternalid = '00000008' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0009' charcinternalid = '00000009' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0010' charcinternalid = '00000010' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0011' charcinternalid = '00000011' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0020' charcinternalid = '00000020' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
        ( characteristic = 'PB_CH_0021' charcinternalid = '00000021' charcdatatype = 'CHAR' validitystartdate = '20170101' validityenddate = '99991231' )
    ).

    lo_charc = cl_cds_test_data=>create( i_data = lt_charc ).
    lo_charc->for_parameters( lt_param_vals ).
    DATA(lo_charc_stub) = environment->get_double( i_name = 'I_ClfnCharcBasic' ).
    lo_charc_stub->insert( lo_charc ).

    lt_alloc = VALUE #(
       ( classinternalid = '00000200' charcinternalid = '00000002' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000200' charcinternalid = '00000001' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000200' charcinternalid = '00000003' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )

       ( classinternalid = '00000210' charcinternalid = '00000004' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000210' charcinternalid = '00000010' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )

       ( classinternalid = '00000100' charcinternalid = '00000005' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )

       ( classinternalid = '00000010' charcinternalid = '00000006' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000010' charcinternalid = '00000007' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000010' charcinternalid = '00000009' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )

       ( classinternalid = '00000020' charcinternalid = '00000007' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000020' charcinternalid = '00000010' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000020' charcinternalid = '00000011' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )

       ( classinternalid = '00000300' charcinternalid = '00000020' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
       ( classinternalid = '00000300' charcinternalid = '00000021' classtype = '001'  validitystartdate = '20170101' validityenddate = '99991231' )
    ).

    lo_alloc = cl_cds_test_data=>create( i_data = lt_alloc ).
    lo_alloc->for_parameters( lt_param_vals ).
    DATA(lo_alloc_stub) = environment->get_double( i_name = 'I_ClfnClassCharcBasic' ).
    lo_alloc_stub->insert( lo_alloc ).

    lt_classsuperior = VALUE #(
       ( class = 'PB_CH_020' classinternalid = '00000020' classtype = '001' ancestorclass = 'PB_CH_020'  ancestorclassinternalid = '00000020' )
       ( class = 'PB_CH_020' classinternalid = '00000020' classtype = '001' ancestorclass = 'PB_CH_100'  ancestorclassinternalid = '00000100' )
       ( class = 'PB_CH_020' classinternalid = '00000020' classtype = '001' ancestorclass = 'PB_CH_010'  ancestorclassinternalid = '00000010' )
       ( class = 'PB_CH_020' classinternalid = '00000020' classtype = '001' ancestorclass = 'PB_CH_200'  ancestorclassinternalid = '00000200' )
       ( class = 'PB_CH_020' classinternalid = '00000020' classtype = '001' ancestorclass = 'PB_CH_210'  ancestorclassinternalid = '00000210' )

       ( class = 'PB_CH_300' classinternalid = '00000300' classtype = '001' ancestorclass = 'PB_CH_300'  ancestorclassinternalid = '00000300' )
    ).

    lo_classsuperior = cl_cds_test_data=>create( i_data = lt_classsuperior ).
    lo_classsuperior->for_parameters( lt_param_vals ).
    DATA(lo_classsuperior_stub) = environment->get_double( i_name = 'I_ClfnClassSuperiorForKeyDate' ).
    lo_classsuperior_stub->insert( lo_classsuperior ).

  ENDMETHOD.

  METHOD check.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasshiercharcforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasshiercharcforkeydate( p_keydate = '20170210' )
      WHERE class = 'PB_CH_020'
      INTO TABLE @act_results.

    SORT act_results BY ancestorclassinternalid charcinternalid.

    exp_results = VALUE #(
        ( classinternalid = '0000000020' charcinternalid = '00000001' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_200' ancestorclassinternalid = '0000000200' characteristic = 'PB_CH_0001'
           charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000020' charcinternalid = '00000002' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_200' ancestorclassinternalid = '0000000200' characteristic = 'PB_CH_0002'
           charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000020' charcinternalid = '00000003' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_200' ancestorclassinternalid = '0000000200' characteristic = 'PB_CH_0003'
           charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000020' charcinternalid = '00000004' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_210' ancestorclassinternalid = '0000000210' characteristic = 'PB_CH_0004'
           charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000020' charcinternalid = '00000005' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_100' ancestorclassinternalid = '0000000100' characteristic = 'PB_CH_0005'
           charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000020' charcinternalid = '00000006' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_010' ancestorclassinternalid = '0000000010' characteristic = 'PB_CH_0006'
           charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000020' charcinternalid = '00000007' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_020' ancestorclassinternalid = '0000000020' characteristic = 'PB_CH_0007'
           charcisinherited = '' validitystartdate = '20170101' validityenddate = '99991231'   )
        ( classinternalid = '0000000020' charcinternalid = '00000009' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_010' ancestorclassinternalid = '0000000010' characteristic = 'PB_CH_0009'
           charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000020' charcinternalid = '00000010' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_020' ancestorclassinternalid = '0000000020' characteristic = 'PB_CH_0010'
           charcisinherited = '' validitystartdate = '20170101' validityenddate = '99991231'   )
        ( classinternalid = '0000000020' charcinternalid = '00000011' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_020' ancestorclassinternalid = '0000000020' characteristic = 'PB_CH_0011'
           charcisinherited = '' validitystartdate = '20170101' validityenddate = '99991231'   )

        ( classinternalid = '0000000020' charcinternalid = '00000010' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_210' ancestorclassinternalid = '0000000210' characteristic = 'PB_CH_0010'
          charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'   )
        ( classinternalid = '0000000020' charcinternalid = '00000007' class = 'PB_CH_020' classtype = '001' ancestorclass = 'PB_CH_010' ancestorclassinternalid = '0000000010' characteristic = 'PB_CH_0007'
          charcisinherited = 'X' validitystartdate = '20170101' validityenddate = '99991231'   )
    ).

    SORT exp_results BY ancestorclassinternalid charcinternalid.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD check_wo_validity.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasshiercharcforkeydate WITH EMPTY KEY.

    SELECT * FROM i_clfnclasshiercharcforkeydate( p_keydate = '20170210' )
      WHERE class = 'PB_CH_300'
      INTO TABLE @act_results.

    SORT act_results BY ancestorclassinternalid charcinternalid.

    exp_results = VALUE #(
        ( classinternalid = '0000000300' charcinternalid = '00000020' class = 'PB_CH_300' classtype = '001' ancestorclass = 'PB_CH_300' ancestorclassinternalid = '0000000300' characteristic = 'PB_CH_0020'
           charcisinherited = '' validitystartdate = '20170101' validityenddate = '99991231'  )
        ( classinternalid = '0000000300' charcinternalid = '00000021' class = 'PB_CH_300' classtype = '001' ancestorclass = 'PB_CH_300' ancestorclassinternalid = '0000000300' characteristic = 'PB_CH_0021'
           charcisinherited = '' validitystartdate = '20170101' validityenddate = '99991231'  )
    ).

    SORT exp_results BY ancestorclassinternalid charcinternalid.

    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.


ENDCLASS.