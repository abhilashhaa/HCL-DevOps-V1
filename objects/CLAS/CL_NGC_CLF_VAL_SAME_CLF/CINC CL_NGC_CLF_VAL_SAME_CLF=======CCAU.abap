CLASS lth_ngc_clf_val_same_clf DEFINITION.

  PUBLIC SECTION.
    CLASS-DATA:
      gt_classes   TYPE ngct_class_object,
      gt_valuation TYPE TABLE OF i_clfnobjectcharcvalforkeydate.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS ltc_ngc_clf_val_same_clf DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_val_same_clf TYPE REF TO cl_ngc_clf_val_same_clf.

    METHODS:
      setup.

    METHODS:
      get_class_test_doubles
        RETURNING
          VALUE(rt_class) TYPE ngct_class_object.

    METHODS:
      object_with_same_class FOR TESTING,
      char_multiple_class_and_object FOR TESTING,
      partly_different_clf FOR TESTING,
      num_interval_1_exists FOR TESTING,
      num_interval_3_exists FOR TESTING,
      num_interval_7_exists FOR TESTING,
      num_interval_9_exists FOR TESTING,
      num_no_interval FOR TESTING,
      empty_valuation FOR TESTING.

ENDCLASS.


CLASS lth_ngc_clf_val_same_clf IMPLEMENTATION.

  METHOD class_constructor.

    gt_classes = VALUE #(
      ( classinternalid = '0000000001' )
      ( classinternalid = '0000000002' )
      ( classinternalid = '0000000003' ) ).

    gt_valuation = VALUE #(
      ( clfnobjectid = 'TEST_OBJECT_02' charcinternalid = '0000000001' clfnobjecttype = 'O' charcvalue = 'EXISTS_01' )
      ( clfnobjectid = 'TEST_OBJECT_03' charcinternalid = '0000000001' clfnobjecttype = 'O' charcvalue = 'EXISTS_01' )

      ( clfnobjectid = 'TEST_OBJECT_02' charcinternalid = '0000000002' clfnobjecttype = 'O' charcvalue = 'EXISTS_02' )
      ( clfnobjectid = 'TEST_OBJECT_03' charcinternalid = '0000000002' clfnobjecttype = 'O' charcvalue = 'EXISTS_02' )

      ( clfnobjectid = 'TEST_OBJECT_02' charcinternalid = '0000000003' clfnobjecttype = 'O' charcfromnumericvalue = 100 charcvaluedependency = 6 )
      ( clfnobjectid = 'TEST_OBJECT_02' charcinternalid = '0000000003' clfnobjecttype = 'O' charcfromnumericvalue = 200 charcvaluedependency = 3 charctonumericvalue = 300 )
      ( clfnobjectid = 'TEST_OBJECT_02' charcinternalid = '0000000003' clfnobjecttype = 'O' charcfromnumericvalue = 400 charcvaluedependency = 1 )
      ( clfnobjectid = 'TEST_OBJECT_02' charcinternalid = '0000000003' clfnobjecttype = 'O' charcfromnumericvalue = 500 charcvaluedependency = 9 )

      ( clfnobjectid = 'TEST_OBJECT_02' charcinternalid = '0000000004' clfnobjecttype = 'O' charcfromnumericvalue = 400 charcvaluedependency = 1 ) ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_ngc_clf_val_same_clf IMPLEMENTATION.

  METHOD setup.

    mo_val_same_clf = NEW #( ).

    TEST-INJECTION select_same_valuation.
      LOOP AT lth_ngc_clf_val_same_clf=>gt_valuation INTO DATA(ls_test_valuation)
        WHERE
          (lt_where_condition).
        IF ls_test_valuation-charcinternalid     = ls_characteristic-charcinternalid
        AND ls_test_valuation-clfnobjectid        = ls_object-clfnobjectid
        AND ls_test_valuation-classtype           = ls_object-classtype
        AND ls_test_valuation-clfnobjecttype      = 'O'.
          lv_same_clf_exists = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.
    END-TEST-INJECTION.

  ENDMETHOD.

  METHOD object_with_same_class.

    DATA:
      lo_classification TYPE REF TO if_ngc_classification,
      lo_validation_dp  TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 1 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000001' charcvalue = 'NOT_EXISTS' ) ) ).
    lo_classification->get_assigned_values( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_01' )
        ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_02' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_false ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
      io_classification = lo_classification
      io_data_provider  = lo_validation_dp
      iv_classtype      = '001'  ).

*   Assertions
    cl_abap_unit_assert=>assert_initial(
      act = lo_result->get_messages( )
      msg = 'Messages should not be returned' ).

  ENDMETHOD.

  METHOD char_multiple_class_and_object.

    DATA:
      lo_classification TYPE REF TO if_ngc_classification,
      lo_validation_dp  TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 1 ] )
        ( lt_class[ 2 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000001' charcvalue = 'EXISTS_01' )
        ( charcinternalid = '0000000002' charcvalue = 'EXISTS_02' )
        ( charcinternalid = '0000000002' charcvalue = 'NOT_EXISTS' ) ) ).
    lo_classification->get_assigned_values( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      IF ls_class-classinternalid = '0000000001'.
        rt_same_objects = VALUE #(
          ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
          ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' )
          ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_03' clfnobjectinternalid = '0000000003' ) ).
      ELSE.
        rt_same_objects = VALUE #(
          ( classinternalid = '0000000002' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
          ( classinternalid = '0000000002' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
      ENDIF.
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
      io_classification = lo_classification
      io_data_provider  = lo_validation_dp
      iv_classtype      = '001'  ).

*   Assertions
    DATA(lt_message) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 2
      msg = 'Messages should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgty
      exp = 'W'
      msg = 'Message type should be W' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgno
      exp = '018'
      msg = 'Message should be for multiple objects' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 2 ]-msgty
      exp = 'E'
      msg = 'Message type should be E' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 2 ]-msgno
      exp = '019'
      msg = 'Message should be for single object' ).

  ENDMETHOD.

  METHOD partly_different_clf.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 2 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000001' charcvalue = 'EXISTS_01' )
        ( charcinternalid = '0000000002' charcvalue = 'NOT_EXISTS' ) ) ).
    lo_classification->get_assigned_values( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
        ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
      io_classification = lo_classification
      io_data_provider  = lo_validation_dp
      iv_classtype      = '001' ).

*   Assertions
    cl_abap_unit_assert=>assert_initial(
      act = lo_result->get_messages( )
      msg = 'Messages should not be returned' ).

  ENDMETHOD.

  METHOD num_interval_1_exists.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 3 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

    DATA(lt_existing_valuation) = VALUE ngct_valuation_data(
      ( charcinternalid = '0000000003' charcvaluedependency = 1 charcfromnumericvalue = 50 )
      ( charcinternalid = '0000000003' charcvaluedependency = 1 charcfromnumericvalue = 250 )
      ( charcinternalid = '0000000003' charcvaluedependency = 1 charcfromnumericvalue = 400 )
      ( charcinternalid = '0000000003' charcvaluedependency = 1 charcfromnumericvalue = 600 ) ).

    LOOP AT lt_existing_valuation INTO DATA(ls_existing_valuation).
      cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
        name  = 'et_valuation_data'
        value = VALUE ngct_valuation_data(
          ( ls_existing_valuation ) ) ).
      lo_classification->get_assigned_values( ).

*     Actions
      DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
        io_classification = lo_classification
        io_data_provider  = lo_validation_dp
        iv_classtype      = '001' ).

*     Assertions
      DATA(lt_message) = lo_result->get_messages( ).

      cl_abap_unit_assert=>assert_equals(
        act = lines( lt_message )
        exp = 1
        msg = 'Message should be returned' ).

      cl_abap_unit_assert=>assert_equals(
        act = lt_message[ 1 ]-msgty
        exp = 'W'
        msg = 'Message type should be W' ).

      cl_abap_unit_assert=>assert_equals(
        act = lt_message[ 1 ]-msgno
        exp = '019'
        msg = 'Message should be for single object' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD num_interval_3_exists.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 3 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

    DATA(lt_existing_valuation) = VALUE ngct_valuation_data(
      ( charcinternalid = '0000000003' charcvaluedependency = 3 charcfromnumericvalue = 50  charctonumericvalue = 150 )
      ( charcinternalid = '0000000003' charcvaluedependency = 3 charcfromnumericvalue = 250 charctonumericvalue = 350 )
      ( charcinternalid = '0000000003' charcvaluedependency = 3 charcfromnumericvalue = 350 charctonumericvalue = 450 )
      ( charcinternalid = '0000000003' charcvaluedependency = 3 charcfromnumericvalue = 450 charctonumericvalue = 500 ) ).

    LOOP AT lt_existing_valuation INTO DATA(ls_existing_valuation).
      cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
        name  = 'et_valuation_data'
        value = VALUE ngct_valuation_data(
          ( ls_existing_valuation ) ) ).
      lo_classification->get_assigned_values( ).

*     Actions
      DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
        io_classification = lo_classification
        io_data_provider  = lo_validation_dp
        iv_classtype      = '001' ).

*     Assertions
      DATA(lt_message) = lo_result->get_messages( ).

      cl_abap_unit_assert=>assert_equals(
        act = lines( lt_message )
        exp = 1
        msg = 'Message should be returned' ).

      cl_abap_unit_assert=>assert_equals(
        act = lt_message[ 1 ]-msgty
        exp = 'W'
        msg = 'Message type should be W' ).

      cl_abap_unit_assert=>assert_equals(
        act = lt_message[ 1 ]-msgno
        exp = '019'
        msg = 'Message should be for single object' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD num_interval_7_exists.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 3 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000003' charcvaluedependency = 7 charcfromnumericvalue = 500 ) ) ).
    lo_classification->get_assigned_values( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
      io_classification = lo_classification
      io_data_provider  = lo_validation_dp
      iv_classtype      = '001' ).

*   Assertions
    DATA(lt_message) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Message should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgty
      exp = 'W'
      msg = 'Message type should be W' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgno
      exp = '019'
      msg = 'Message should be for single object' ).

  ENDMETHOD.

  METHOD num_interval_9_exists.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 3 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000003' charcvaluedependency = 9 charcfromnumericvalue = 50 ) ) ).
    lo_classification->get_assigned_values( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
        ( classinternalid = '0000000003' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
      io_classification = lo_classification
      io_data_provider  = lo_validation_dp
      iv_classtype      = '001' ).

*   Assertions
    DATA(lt_message) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Message should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgty
      exp = 'W'
      msg = 'Message type should be W' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgno
      exp = '019'
      msg = 'Message should be for single object' ).

  ENDMETHOD.

  METHOD num_no_interval.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 4 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000004' charcfromnumericvalue = 400 ) ) ).
    lo_classification->get_assigned_values( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000004' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
        ( classinternalid = '0000000004' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
      io_classification = lo_classification
      io_data_provider  = lo_validation_dp
      iv_classtype      = '001' ).

*   Assertions
    DATA(lt_message) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Message should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgty
      exp = 'W'
      msg = 'Message type should be W' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_message[ 1 ]-msgno
      exp = '019'
      msg = 'Message should be for single object' ).

  ENDMETHOD.

  METHOD empty_valuation.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

*   Arrangements

    " Create test double for classification
    DATA(lt_class) = get_class_test_doubles( ).

    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_assigned_class'
      value = VALUE ngct_class_object(
        ( lt_class[ 1 ] ) ) ).
    lo_classification->get_assigned_classes( ).

    cl_abap_testdouble=>configure_call( lo_classification )->returning(
      VALUE ngcs_classification_key( key_date = '20170101' object_key = 'TEST_OBJECT_01' technical_object = 'MARA' ) ).
    lo_classification->get_classification_key( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data( ) ).
    lo_classification->get_assigned_values( ).

    " Create test doubles for validation dp
    lo_validation_dp ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).

    " Test injections
    TEST-INJECTION select_same_object.
      rt_same_objects = VALUE #(
        ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_01' clfnobjectinternalid = '0000000001' )
        ( classinternalid = '0000000001' clfnobjectid = 'TEST_OBJECT_02' clfnobjectinternalid = '0000000002' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_class_type_details.
      ls_classtype = VALUE #( classtype = '001' multipleobjtableclfnisallowed = abap_true ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_val_same_clf->if_ngc_clf_validator~validate(
      io_classification = lo_classification
      io_data_provider  = lo_validation_dp
      iv_classtype      = '001' ).

*   Assertions
    cl_abap_unit_assert=>assert_initial(
      act = lo_result->get_messages( )
      msg = 'Message should be returned' ).

  ENDMETHOD.

  METHOD get_class_test_doubles.

    DATA:
      lo_characteristic_1 TYPE REF TO if_ngc_characteristic,
      lo_characteristic_2 TYPE REF TO if_ngc_characteristic,
      lo_characteristic_3 TYPE REF TO if_ngc_characteristic,
      lo_characteristic_4 TYPE REF TO if_ngc_characteristic,
      lo_class_1          TYPE REF TO if_ngc_class,
      lo_class_2          TYPE REF TO if_ngc_class,
      lo_class_3          TYPE REF TO if_ngc_class,
      lo_class_4          TYPE REF TO if_ngc_class,
      lo_classification   TYPE REF TO if_ngc_classification,
      lo_validation_dp    TYPE REF TO if_ngc_clf_validation_dp.

    " Create test double for characteristics
    lo_characteristic_1 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( lo_characteristic_1 )->returning(
      VALUE ngcs_characteristic(
        charcinternalid        = '0000000001'
        charcdatatype          = if_ngc_c=>gc_charcdatatype-char  ) ).
    lo_characteristic_1->get_header( ).

    lo_characteristic_2 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( lo_characteristic_2 )->returning(
      VALUE ngcs_characteristic(
        charcinternalid        = '0000000002'
        charcdatatype          = if_ngc_c=>gc_charcdatatype-char  ) ).
    lo_characteristic_2->get_header( ).

    lo_characteristic_3 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( lo_characteristic_3 )->returning(
      VALUE ngcs_characteristic(
        charcinternalid        = '0000000003'
        valueintervalisallowed = abap_true
        charcdatatype          = if_ngc_c=>gc_charcdatatype-num  ) ).
    lo_characteristic_3->get_header( ).

    lo_characteristic_4 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( lo_characteristic_4 )->returning(
      VALUE ngcs_characteristic(
        charcinternalid        = '0000000004'
        valueintervalisallowed = abap_false
        charcdatatype          = if_ngc_c=>gc_charcdatatype-num  ) ).
    lo_characteristic_4->get_header( ).

    " Create test double for classes
    lo_class_1 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( lo_class_1 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object(
        ( charcinternalid = '0000000001' characteristic_object = lo_characteristic_1 ) ) ).
    lo_class_1->get_characteristics( ).

    cl_abap_testdouble=>configure_call( lo_class_1 )->returning(
      VALUE ngcs_class(
        classinternalid       = '0000000001'
        sameclassfctnreaction = 'W' ) ).
    lo_class_1->get_header( ).

    lo_class_2 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( lo_class_2 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object(
        ( charcinternalid = '0000000001' characteristic_object = lo_characteristic_1 )
        ( charcinternalid = '0000000002' characteristic_object = lo_characteristic_2 ) ) ).
    lo_class_2->get_characteristics( ).

    cl_abap_testdouble=>configure_call( lo_class_2 )->returning(
      VALUE ngcs_class(
        classinternalid       = '0000000002'
        sameclassfctnreaction = 'E' ) ).
    lo_class_2->get_header( ).

    lo_class_3 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( lo_class_3 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object(
        ( charcinternalid = '0000000003' characteristic_object = lo_characteristic_3 ) ) ).
    lo_class_3->get_characteristics( ).

    cl_abap_testdouble=>configure_call( lo_class_3 )->returning(
      VALUE ngcs_class(
        classinternalid       = '0000000003'
        sameclassfctnreaction = 'W' ) ).
    lo_class_3->get_header( ).

    lo_class_4 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( lo_class_4 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object(
        ( charcinternalid = '0000000004' characteristic_object = lo_characteristic_4 ) ) ).
    lo_class_4->get_characteristics( ).

    cl_abap_testdouble=>configure_call( lo_class_4 )->returning(
      VALUE ngcs_class(
        classinternalid       = '0000000004'
        sameclassfctnreaction = 'W' ) ).
    lo_class_4->get_header( ).

    rt_class = VALUE #(
      ( classinternalid = '0000000001' class_object = lo_class_1 )
      ( classinternalid = '0000000002' class_object = lo_class_2 )
      ( classinternalid = '0000000003' class_object = lo_class_3 )
      ( classinternalid = '0000000004' class_object = lo_class_4 ) ).

  ENDMETHOD.

ENDCLASS.