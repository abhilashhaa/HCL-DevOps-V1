CLASS lcl_ngc_clf_status DEFINITION DEFERRED.
CLASS cl_ngc_clf_status  DEFINITION LOCAL FRIENDS lcl_ngc_clf_status.

CLASS lth_ngc_clf_status DEFINITION FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      go_characteristic_1 TYPE REF TO if_ngc_characteristic,
      go_characteristic_2 TYPE REF TO if_ngc_characteristic,
      go_characteristic_3 TYPE REF TO if_ngc_characteristic,
      go_characteristic_4 TYPE REF TO if_ngc_characteristic,
      go_class_1          TYPE REF TO if_ngc_class,
      go_class_2          TYPE REF TO if_ngc_class,
      go_class_3          TYPE REF TO if_ngc_class,
      go_class_4          TYPE REF TO if_ngc_class.
    CLASS-METHODS:
      class_constructor.
ENDCLASS.

CLASS lth_ngc_clf_status IMPLEMENTATION.
  METHOD class_constructor.
    go_characteristic_1 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( go_characteristic_1 )->returning( VALUE ngcs_characteristic(
      charcinternalid = '0000000001' entryisrequired = abap_true ) ).
    go_characteristic_1->get_header( ).

    go_characteristic_2 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( go_characteristic_2 )->returning( VALUE ngcs_characteristic(
      charcinternalid = '0000000002' entryisrequired = abap_true ) ).
    go_characteristic_2->get_header( ).

    go_characteristic_3 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( go_characteristic_3 )->returning( VALUE ngcs_characteristic(
      charcinternalid = '0000000002' entryisrequired = abap_true ) ).
    go_characteristic_3->get_header( ).

    go_characteristic_4 ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
    cl_abap_testdouble=>configure_call( go_characteristic_4 )->returning( VALUE ngcs_characteristic(
      charcinternalid = '0000000002' entryisrequired = abap_true ) ).
    go_characteristic_4->get_header( ).

    " Class test doubles
    go_class_1 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( go_class_1 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object( ( charcinternalid = '000000001' characteristic_object = go_characteristic_1 ) ) ).
    go_class_1->get_characteristics( ).

    go_class_2 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( go_class_2 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object( ( charcinternalid = '000000002' characteristic_object = go_characteristic_2 ) ) ).
    go_class_2->get_characteristics( ).

    go_class_3 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( go_class_3 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object( ( charcinternalid = '000000003' characteristic_object = go_characteristic_3 ) ) ).
    go_class_3->get_characteristics( ).

    go_class_4 ?= cl_abap_testdouble=>create( 'if_ngc_class' ).
    cl_abap_testdouble=>configure_call( go_class_4 )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_characteristic_object( ( charcinternalid = '000000004' characteristic_object = go_characteristic_4 ) ) ).
    go_class_4->get_characteristics( ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_classification DEFINITION FOR TESTING.
  PUBLIC SECTION.
    DATA mt_clf_data TYPE ngct_classification_data.
    METHODS constructor
      IMPORTING it_clf_data TYPE ngct_classification_data.
    INTERFACES:
      if_ngc_classification PARTIALLY IMPLEMENTED, if_ngc_clf_validation_dp PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_classification IMPLEMENTATION.
  METHOD constructor.
    mt_clf_data = it_clf_data.
  ENDMETHOD.

  METHOD if_ngc_classification~get_assigned_classes.
    et_classification_data = mt_clf_data.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_ngc_clf_status DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_status.

    METHODS:
      setup,
      get_classification_stub
        IMPORTING it_classification_data   TYPE ngct_classification_data OPTIONAL
        RETURNING VALUE(ro_classification) TYPE REF TO if_ngc_classification.

    METHODS:
      refresh_status_manually       FOR TESTING,
      refresh_status_by_system      FOR TESTING,
      change_locked_to_incomplete   FOR TESTING,
      change_locked_to_released     FOR TESTING,
      change_incomplete_to_locked   FOR TESTING,
      change_incomplete_to_released FOR TESTING,
      change_released_to_locked     FOR TESTING,
      change_released_to_incomplete FOR TESTING,
      get_classtype_status          FOR TESTING.
ENDCLASS.


CLASS lcl_ngc_clf_status IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_clf_persistency           TYPE REF TO if_ngc_core_clf_persistency,
      lo_domain_value_validator    TYPE REF TO if_ngc_clf_validator,
      lo_value_used_leaf_validator TYPE REF TO if_ngc_clf_validator.

    mo_cut = NEW cl_ngc_clf_status( ).

    lo_clf_persistency        ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    lo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).
    cl_abap_testdouble=>configure_call( lo_clf_persistency )->ignore_all_parameters( )->returning( VALUE ngct_core_classification_stat(
      ( statu = '1' frei      = abap_true )
      ( statu = '2' gesperrt  = abap_true )
      ( statu = '3' unvollstm = abap_true )
      ( statu = '5' unvollsts = abap_true ) ) ).
    lo_clf_persistency->read_clf_statuses( '' ).

    lo_domain_value_validator    ?= cl_abap_testdouble=>create( 'if_ngc_clf_validator' ).
    lo_value_used_leaf_validator ?= cl_abap_testdouble=>create( 'if_ngc_clf_validator' ).

    mo_cut->mo_clf_persistency           = lo_clf_persistency.
    mo_cut->mo_domain_value_validator    = lo_domain_value_validator.
    mo_cut->mo_value_used_leaf_validator = lo_value_used_leaf_validator.

  ENDMETHOD.

  METHOD refresh_status_manually.

    DATA lo_classification TYPE REF TO if_ngc_classification.

*   Arrangements
    lo_classification = get_classification_stub( VALUE ngct_classification_data(
        ( classinternalid = '0000000001' clfnstatus = '2' )
        ( classinternalid = '0000000002' clfnstatus = '3' ) ) ).

    cl_abap_testdouble=>configure_call( lo_classification )->ignore_all_parameters( )->and_expect( )->is_never_called( ).
    lo_classification->modify_classification_data( VALUE #( ) ).

*   Actions
    mo_cut->if_ngc_clf_status~refresh_status(
      EXPORTING
        io_classification = lo_classification
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD refresh_status_by_system.

    DATA:
      lo_classification  TYPE REF TO if_ngc_classification,
      lo_clf_persistency TYPE REF TO if_ngc_core_clf_persistency.

*   Arrangements

    lo_classification = get_classification_stub( VALUE ngct_classification_data(
          ( classtype = '001' classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '1' )
          ( classtype = '001' classinternalid = '0000000002' clfnstatus = '5' classpositionnumber = '2' )
          ( classtype = '001' classinternalid = '0000000003' clfnstatus = '1' classpositionnumber = '3' )
          ( classtype = '001' classinternalid = '0000000004' clfnstatus = '5' classpositionnumber = '4' ) ) ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000002' charcvalue = 'VALUE' )
        ( charcinternalid = '0000000003' charcvalue = 'VALUE' ) ) ).
    lo_classification->get_assigned_values( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) )->and_expect( )->is_called_once( ).
    lo_classification->modify_classification_data( VALUE #(
      ( classinternalid = '0000000001' classpositionnumber = '1' clfnstatus = '5' )
      ( classinternalid = '0000000002' classpositionnumber = '2' clfnstatus = '1' ) ) ).

*   Actions

    mo_cut->if_ngc_clf_status~refresh_status(
      EXPORTING
        io_classification = lo_classification
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_equals(
      act = lines( lo_clf_api_result->get_messages( ) )
      exp = 2
      msg = 'Incorrect number of messages returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD change_locked_to_incomplete.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification.

*   Arrangements

    " Classification test doubles
    lo_classification = get_classification_stub( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) )->and_expect( )->is_called_once( ).
    lo_classification->modify_classification_data( VALUE #(
      ( classinternalid = '0000000002' classpositionnumber = '2' clfnstatus = '3' ) ) ).

*   Actions
    mo_cut->if_ngc_clf_status~change_status(
      EXPORTING
        io_classification  = lo_classification
        iv_classinternalid = '0000000002'
        iv_status          = '3'
      IMPORTING
        eo_clf_api_result  = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD change_incomplete_to_locked.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification.

*   Arrangements

    " Classification test doubles
    lo_classification = get_classification_stub( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) )->and_expect( )->is_called_once( ).
    lo_classification->modify_classification_data( VALUE #(
      ( classinternalid = '0000000003' classpositionnumber = '3' clfnstatus = '2' ) ) ).

*   Actions
    mo_cut->if_ngc_clf_status~change_status(
      EXPORTING
        io_classification  = lo_classification
        iv_classinternalid = '0000000003'
        iv_status          = '2'
      IMPORTING
        eo_clf_api_result  = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD change_released_to_locked.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification.

*   Arrangements

    " Classification test doubles
    lo_classification = get_classification_stub( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) )->and_expect( )->is_called_once( ).
    lo_classification->modify_classification_data( VALUE #(
      ( classinternalid = '0000000001' classpositionnumber = '1' clfnstatus = '2' ) ) ).

*   Actions
    mo_cut->if_ngc_clf_status~change_status(
      EXPORTING
        io_classification  = lo_classification
        iv_classinternalid = '0000000001'
        iv_status          = '2'
      IMPORTING
        eo_clf_api_result  = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD change_released_to_incomplete.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification.

*   Arrangements

    " Classification test doubles
    lo_classification = get_classification_stub( ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) )->and_expect( )->is_called_once( ).
    lo_classification->modify_classification_data( VALUE #(
      ( classinternalid = '0000000001' classpositionnumber = '1' clfnstatus = '3' ) ) ).

*   Actions
    mo_cut->if_ngc_clf_status~change_status(
      EXPORTING
        io_classification  = lo_classification
        iv_classinternalid = '0000000001'
        iv_status          = '3'
      IMPORTING
        eo_clf_api_result  = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD change_locked_to_released.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification.

*   Arrangements

    " Classification test doubles
    lo_classification = get_classification_stub( VALUE ngct_classification_data(
        ( classtype = '001' classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '1' )
        ( classtype = '001' classinternalid = '0000000002' clfnstatus = '5' classpositionnumber = '2' )
        ( classtype = '001' classinternalid = '0000000003' clfnstatus = '1' classpositionnumber = '3' )
        ( classtype = '001' classinternalid = '0000000004' clfnstatus = '5' classpositionnumber = '4' ) ) ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) )->and_expect( )->is_called_once( ).
    lo_classification->modify_classification_data( VALUE #(
      ( classinternalid = '0000000002' classpositionnumber = '2' clfnstatus = '1' ) ) ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000002' charcvalue = 'VALUE' )
        ( charcinternalid = '0000000003' charcvalue = 'VALUE' ) ) ).
    lo_classification->get_assigned_values( ).

*   Actions
    mo_cut->if_ngc_clf_status~change_status(
      EXPORTING
        io_classification  = lo_classification
        iv_classinternalid = '0000000002'
        iv_status          = '1'
      IMPORTING
        eo_clf_api_result  = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD change_incomplete_to_released.

    DATA:
      lo_classification   TYPE REF TO if_ngc_classification.

*   Arrangements

    " Classification test doubles
    lo_classification = get_classification_stub( VALUE ngct_classification_data(
        ( classtype = '001' classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '1' )
        ( classtype = '001' classinternalid = '0000000002' clfnstatus = '5' classpositionnumber = '2' )
        ( classtype = '001' classinternalid = '0000000003' clfnstatus = '1' classpositionnumber = '3' )
        ( classtype = '001' classinternalid = '0000000004' clfnstatus = '5' classpositionnumber = '4' ) ) ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) )->and_expect( )->is_called_once( ).
    lo_classification->modify_classification_data( VALUE #(
      ( classinternalid = '0000000003' classpositionnumber = '3' clfnstatus = '1' ) ) ).

    cl_abap_testdouble=>configure_call( lo_classification )->set_parameter(
      name  = 'et_valuation_data'
      value = VALUE ngct_valuation_data(
        ( charcinternalid = '0000000002' charcvalue = 'VALUE' )
        ( charcinternalid = '0000000003' charcvalue = 'VALUE' ) ) ).
    lo_classification->get_assigned_values( ).

*   Actions
    mo_cut->if_ngc_clf_status~change_status(
      EXPORTING
        io_classification  = lo_classification
        iv_classinternalid = '0000000003'
        iv_status          = '1'
      IMPORTING
        eo_clf_api_result  = DATA(lo_clf_api_result) ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_classification ).

  ENDMETHOD.

  METHOD get_classtype_status.
    DATA:
      lo_classification            TYPE REF TO ltd_classification,
      lo_domain_value_validator    TYPE REF TO if_ngc_clf_validator,
      lo_value_used_leaf_validator TYPE REF TO if_ngc_clf_validator,
      lo_ngc_clf_api_result        TYPE REF TO if_ngc_clf_api_result.

**********************************************************************
* RELEASED ***********************************************************
**********************************************************************

*   Arrangements
    " Classification test doubles
    lo_classification = NEW ltd_classification(
      VALUE ngct_classification_data(
        ( classtype = '001' classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '1' )
        ( classtype = '001' classinternalid = '0000000002' clfnstatus = '1' classpositionnumber = '2' ) )
    ).

    lo_domain_value_validator ?= cl_abap_testdouble=>create( 'if_ngc_clf_validator' ).
    mo_cut->mo_domain_value_validator = lo_domain_value_validator.

    cl_abap_testdouble=>configure_call( lo_domain_value_validator )->ignore_all_parameters( )->returning(
      NEW cl_ngc_clf_api_result( )
    ).
    lo_domain_value_validator->validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_classification ).

    lo_value_used_leaf_validator ?= cl_abap_testdouble=>create( 'if_ngc_clf_validator' ).
    mo_cut->mo_value_used_leaf_validator = lo_value_used_leaf_validator.

    cl_abap_testdouble=>configure_call( lo_value_used_leaf_validator )->ignore_all_parameters( )->returning(
      NEW cl_ngc_clf_api_result( )
    ).
    lo_value_used_leaf_validator->validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_classification ).

*   Actions
    mo_cut->if_ngc_clf_status~get_classtype_status(
      EXPORTING
         io_classification = lo_classification
         iv_classtype      = '001'
      IMPORTING
        ev_inconsistent = DATA(lv_inconsistent)
        ev_released     = DATA(lv_released)
    ).

*   Assertions
    cl_abap_unit_assert=>assert_true(
      act = lv_released
      msg = 'Released status expected' ).

    cl_abap_unit_assert=>assert_false(
      act = lv_inconsistent
      msg = 'Inconsistent status not expected' ).

**********************************************************************
* NOT RELEASED *******************************************************
**********************************************************************

*   Arrangements
    lo_classification = NEW ltd_classification(
      VALUE ngct_classification_data(
        ( classtype = '001' classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '1' )
        ( classtype = '001' classinternalid = '0000000002' clfnstatus = '3' classpositionnumber = '2' ) )
    ).

*   Actions
    mo_cut->if_ngc_clf_status~get_classtype_status(
      EXPORTING
         io_classification = lo_classification
         iv_classtype      = '001'
      IMPORTING
        ev_inconsistent = lv_inconsistent
        ev_released     = lv_released
    ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lv_released
      msg = 'Released status not expected' ).

    cl_abap_unit_assert=>assert_false(
      act = lv_inconsistent
      msg = 'Inconsistent status not expected' ).

**********************************************************************
* INCONSISTENT *******************************************************
**********************************************************************

*   Arrangements
    lo_classification = NEW ltd_classification(
      VALUE ngct_classification_data(
        ( classtype = '001' classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '1' )
        ( classtype = '001' classinternalid = '0000000002' clfnstatus = '5' classpositionnumber = '2' ) )
    ).

    lo_domain_value_validator ?= cl_abap_testdouble=>create( 'if_ngc_clf_validator' ).
    mo_cut->mo_domain_value_validator = lo_domain_value_validator.

    lo_ngc_clf_api_result ?= cl_abap_testdouble=>create( 'if_ngc_clf_api_result' ).
    cl_abap_testdouble=>configure_call( lo_ngc_clf_api_result )->ignore_all_parameters( )->returning( abap_true ).
    lo_ngc_clf_api_result->has_message( ).

    cl_abap_testdouble=>configure_call( lo_domain_value_validator )->ignore_all_parameters( )->returning(
      lo_ngc_clf_api_result
    ).
    lo_domain_value_validator->validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_classification ).


*   Actions
    mo_cut->if_ngc_clf_status~get_classtype_status(
      EXPORTING
         io_classification = lo_classification
         iv_classtype      = '001'
      IMPORTING
        ev_inconsistent = lv_inconsistent
        ev_released     = lv_released
    ).

*   Assertions
    cl_abap_unit_assert=>assert_false(
      act = lv_released
      msg = 'Released status not expected' ).

    cl_abap_unit_assert=>assert_true(
      act = lv_inconsistent
      msg = 'Inconsistent status expected' ).

  ENDMETHOD.

  METHOD get_classification_stub.
    DATA: lt_classification_data TYPE ngct_classification_data.

    IF it_classification_data IS INITIAL.
      lt_classification_data = VALUE ngct_classification_data(
          ( classtype = '001' classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '1' )
          ( classtype = '001' classinternalid = '0000000002' clfnstatus = '2' classpositionnumber = '2' )
          ( classtype = '001' classinternalid = '0000000003' clfnstatus = '3' classpositionnumber = '3' )
          ( classtype = '001' classinternalid = '0000000004' clfnstatus = '5' classpositionnumber = '4' ) ).
    ELSE.
      lt_classification_data = it_classification_data.
    ENDIF.

    ro_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( ro_classification
      )->set_parameter(
        name  = 'et_classification_data'
        value = lt_classification_data
      )->set_parameter(
        name  = 'et_assigned_class'
        value = VALUE ngct_class_object(
          ( classinternalid = '0000000001' class_object = lth_ngc_clf_status=>go_class_1 )
          ( classinternalid = '0000000002' class_object = lth_ngc_clf_status=>go_class_2 )
          ( classinternalid = '0000000003' class_object = lth_ngc_clf_status=>go_class_3 )
          ( classinternalid = '0000000004' class_object = lth_ngc_clf_status=>go_class_4 ) ) ).

    ro_classification->get_assigned_classes( ).
  ENDMETHOD.

ENDCLASS.