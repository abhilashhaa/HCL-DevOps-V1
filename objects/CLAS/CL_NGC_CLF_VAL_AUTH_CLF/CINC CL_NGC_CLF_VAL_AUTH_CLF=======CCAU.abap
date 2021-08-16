CLASS ltd_ngc_cls DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_class.
    METHODS constructor
      IMPORTING
        is_header TYPE ngcs_class.
  PRIVATE SECTION.
    DATA: ms_header TYPE ngcs_class.
ENDCLASS.

CLASS ltd_ngc_cls IMPLEMENTATION.
  METHOD constructor.
    ms_header = is_header.
  ENDMETHOD.
  METHOD if_ngc_class~get_header.
    rs_class_header = ms_header.
  ENDMETHOD.
  METHOD if_ngc_class~get_characteristics ##NEEDED.
  ENDMETHOD.
ENDCLASS.


CLASS lth_ngc_clf_val_auth_clf DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_one TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_technical_object TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_classtype TYPE klassenart VALUE '001'.
    CONSTANTS: gc_another_classtype TYPE klassenart VALUE '002'.
    CONSTANTS: gc_classinternalid TYPE clint VALUE '1'.
    CONSTANTS: gc_class TYPE klasse_d VALUE 'CLASS'.
    CONSTANTS: gc_classclassfctnauthgrp_auth TYPE bgrkl VALUE 'YES'.
    CONSTANTS: gc_classclassfctnauthgrp_fail TYPE bgrkl VALUE 'NO'.
    CONSTANTS: gc_classclassfctnauthgrp_init TYPE bgrkl VALUE IS INITIAL.
ENDCLASS.

CLASS lth_ngc_clf_val_auth_clf IMPLEMENTATION.
ENDCLASS.

CLASS ltd_ngc_clf_validation_dp DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_clf_validation_dp PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_clf_validation_dp IMPLEMENTATION.
  METHOD if_ngc_clf_validation_dp~set_updated_data ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~get_validation_class_types ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~update_assigned_values ##NEEDED.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_clf_val_auth_clf DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_auth_clf DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_auth_clf.

CLASS ltc_ngc_clf_val_auth_clf DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_val_auth_clf.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: no_clf FOR TESTING.
    METHODS: clf_no_auth_group FOR TESTING.
    METHODS: clf_auth_fail FOR TESTING.
    METHODS: clf_auth_ok FOR TESTING.
    METHODS: wrong_classtype FOR TESTING.
    METHODS: assert_error_message
      IMPORTING
        it_messages TYPE ngct_classification_msg.
    METHODS: get_classification_stub
      IMPORTING iv_classclassfctnauthgrp TYPE bgrkl
      RETURNING VALUE(ro_classification) TYPE REF TO if_ngc_classification.
ENDCLASS.       "ltc_Ngc_Clf_Val_Auth_Clf


CLASS ltc_ngc_clf_val_auth_clf IMPLEMENTATION.

  METHOD class_setup.


  ENDMETHOD.


  METHOD class_teardown.


  ENDMETHOD.


  METHOD setup.


  ENDMETHOD.


  METHOD teardown.


  ENDMETHOD.


  METHOD no_clf.

* has no assigned classes

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    TEST-INJECTION auth_check.
    END-TEST-INJECTION.

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_auth_clf=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( iv_classclassfctnauthgrp = space ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.


  METHOD clf_no_auth_group.

* has assigned classes, but auth. group is initial

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    TEST-INJECTION auth_check.
      rv_has_auth = abap_true.
    END-TEST-INJECTION.

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_auth_clf=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( lth_ngc_clf_val_auth_clf=>gc_classclassfctnauthgrp_init ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.



  METHOD clf_auth_fail.

* has assigned classes, auth check fails

    mo_cut = NEW #( ).

    TEST-INJECTION auth_check.
    END-TEST-INJECTION.

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_auth_clf=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( lth_ngc_clf_val_auth_clf=>gc_classclassfctnauthgrp_fail ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    assert_error_message( lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD clf_auth_ok.

* has assigned classes, auth check OK

    mo_cut = NEW #( ).

    TEST-INJECTION auth_check.
      rv_has_auth = abap_true.
    END-TEST-INJECTION.

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_auth_clf=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( lth_ngc_clf_val_auth_clf=>gc_classclassfctnauthgrp_auth ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.


  METHOD wrong_classtype.

* class type wrong

    mo_cut = NEW #( ).

    TEST-INJECTION auth_check.
      rv_has_auth = abap_true.
    END-TEST-INJECTION.

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_auth_clf=>gc_another_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( lth_ngc_clf_val_auth_clf=>gc_classclassfctnauthgrp_auth ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).


  ENDMETHOD.


  METHOD get_classification_stub.

    ro_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).
    IF iv_classclassfctnauthgrp IS NOT INITIAL.
      cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
        )->set_parameter(
          name  = 'et_classification_data_upd'
          value = VALUE ngct_classification_data_upd( ( classinternalid = lth_ngc_clf_val_auth_clf=>gc_classinternalid ) )
        )->set_parameter(
          name  = 'et_assigned_class_upd'
          value = VALUE ngct_class_object_upd( ( classinternalid = lth_ngc_clf_val_auth_clf=>gc_classinternalid
                             key_date        = lth_ngc_clf_val_auth_clf=>gc_key_date
                             class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid         = lth_ngc_clf_val_auth_clf=>gc_classinternalid
                                                                         classtype               = lth_ngc_clf_val_auth_clf=>gc_classtype
                                                                         class                   = lth_ngc_clf_val_auth_clf=>gc_class
                                                                         classclassfctnauthgrp   = iv_classclassfctnauthgrp ) )
                             object_state    = if_ngc_c=>gc_object_state-created ) )
        ).
    ELSE.
      cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
        )->set_parameter(
          name  = 'et_classification_data_upd'
          value = VALUE ngct_classification_data_upd( ( classinternalid = lth_ngc_clf_val_auth_clf=>gc_classinternalid ) )
        )->set_parameter(
          name  = 'et_assigned_class_upd'
          value = VALUE ngct_class_object_upd( )
        ).
    ENDIF.
    ro_classification->get_updated_data( ).

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters( )->returning(
      VALUE ngcs_classification_key(
        object_key       = lth_ngc_clf_val_auth_clf=>gc_object_key_one
        technical_object = lth_ngc_clf_val_auth_clf=>gc_technical_object
        key_date         = lth_ngc_clf_val_auth_clf=>gc_key_date
        change_number    = space ) ).
    ro_classification->get_classification_key( ).

  ENDMETHOD.

  METHOD assert_error_message.
    MESSAGE e006(ngc_api_base) WITH lth_ngc_clf_val_auth_clf=>gc_class INTO DATA(lv_msg) ##NEEDED.
    READ TABLE it_messages TRANSPORTING NO FIELDS WITH KEY object_key       = lth_ngc_clf_val_auth_clf=>gc_object_key_one
                                                           technical_object = lth_ngc_clf_val_auth_clf=>gc_technical_object
                                                           key_date         = lth_ngc_clf_val_auth_clf=>gc_key_date
                                                           change_number    = space
                                                           msgid            = sy-msgid
                                                           msgty            = sy-msgty
                                                           msgno            = sy-msgno
                                                           msgv1            = sy-msgv1
                                                           msgv2            = sy-msgv2
                                                           msgv3            = sy-msgv3
                                                           msgv4            = sy-msgv4.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Unexpected messages were returned' ).
  ENDMETHOD.


ENDCLASS.