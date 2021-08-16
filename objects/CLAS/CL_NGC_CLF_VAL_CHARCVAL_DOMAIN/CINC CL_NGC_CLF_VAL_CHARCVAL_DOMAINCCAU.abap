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
  METHOD if_ngc_class~get_characteristics.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_chr DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_characteristic.
    METHODS constructor
      IMPORTING
        is_header TYPE ngcs_characteristic.
  PRIVATE SECTION.
    DATA: ms_header TYPE ngcs_characteristic.
ENDCLASS.

CLASS ltd_ngc_chr IMPLEMENTATION.
  METHOD constructor.
    ms_header = is_header.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_header.
    rs_characteristic_header = ms_header.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_domain_values.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_characteristic_ref.
  ENDMETHOD.
ENDCLASS.

CLASS lth_ngc_clf_val_charcval_doma DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_one TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_technical_object TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_classtype TYPE klassenart VALUE '001'.
    CONSTANTS: gc_another_classtype TYPE klassenart VALUE '002'.
    CONSTANTS: gc_classinternalid TYPE clint VALUE '1'.
    CONSTANTS: gc_class TYPE klasse_d VALUE 'CLASS'.
    CONSTANTS: gc_charcinternalid TYPE atinn VALUE '00001001'.
ENDCLASS.

CLASS lth_ngc_clf_val_charcval_doma IMPLEMENTATION.
ENDCLASS.

CLASS ltd_ngc_clf_validation_dp DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_clf_validation_dp PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_clf_validation_dp IMPLEMENTATION.
  METHOD if_ngc_clf_validation_dp~set_updated_data.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~get_validation_class_types.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~update_assigned_values.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_clf_val_charcval_doma DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_charcval_domain DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_charcval_doma.

CLASS ltc_ngc_clf_val_charcval_doma DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_val_charcval_domain.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: no_clf FOR TESTING.
    METHODS: char_cstic_not_in_dom_vals    FOR TESTING.
    METHODS: char_cstic_in_dom_vals        FOR TESTING.
    METHODS: char_cstic_no_dom_vals        FOR TESTING.
    METHODS: atcod1_cstic                  FOR TESTING.
    METHODS: atcod2_cstic                  FOR TESTING.
    METHODS: atcod3_cstic                  FOR TESTING.
    METHODS: atcod4_cstic                  FOR TESTING.
    METHODS: atcod5_cstic                  FOR TESTING.
    METHODS: atcod6_cstic                  FOR TESTING.
    METHODS: atcod7_cstic                  FOR TESTING.
    METHODS: atcod8_cstic                  FOR TESTING.
    METHODS: atcod9_cstic                  FOR TESTING.
    METHODS: assert_error_message
      IMPORTING io_clf_api_result TYPE REF TO if_ngc_clf_api_result.
    METHODS: get_classification_empty_stub
      RETURNING VALUE(ro_classification) TYPE REF TO if_ngc_classification.
    METHODS: get_classification_stub
      IMPORTING iv_include_clf           TYPE abap_bool DEFAULT abap_true
                iv_charcvalue            TYPE data      OPTIONAL
                iv_charcdatatype         TYPE atfor     DEFAULT '1'
                iv_charcvaluedependency  TYPE atcod     DEFAULT '1'
                iv_charcfromnumericvalue TYPE atflv     OPTIONAL
                iv_charctonumericvalue   TYPE atflb     OPTIONAL
      RETURNING VALUE(ro_classification) TYPE REF TO if_ngc_classification.

ENDCLASS.       "ltc_ngc_clf_val_charcval_doma


CLASS ltc_ngc_clf_val_charcval_doma IMPLEMENTATION.

  METHOD class_setup.


  ENDMETHOD.


  METHOD class_teardown.


  ENDMETHOD.


  METHOD setup.


  ENDMETHOD.


  METHOD teardown.


  ENDMETHOD.


  METHOD no_clf.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_empty_stub( ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.

  METHOD char_cstic_not_in_dom_vals.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).


    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( iv_charcvalue = 'INVALID_CHARC_VALUE' iv_charcdatatype = 'CHAR' ) ).

    assert_error_message( lo_clf_api_result ).

  ENDMETHOD.

  METHOD char_cstic_in_dom_vals.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( iv_charcvalue = 'CHARC_VALUE' iv_charcdatatype = 'CHAR' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.

  METHOD char_cstic_no_dom_vals.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

*    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
*                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
*                                                                     io_classification = get_classification_stub( ) ).
*
*    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
*                                         msg = 'Unexpected messages were returned' ).
  ENDMETHOD.



  METHOD atcod1_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).


    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '2'
                                                                        iv_charcfromnumericvalue = '2'
                                                                        iv_charcdatatype         = 'NUM' ) ).


    assert_error_message( lo_clf_api_result ).

    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '5'
                                                                        iv_charcfromnumericvalue = '5'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '7'
                                                                        iv_charcfromnumericvalue = '7'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '20'
                                                                        iv_charcfromnumericvalue = '20'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '29'
                                                                        iv_charcfromnumericvalue = '29'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '33'
                                                                        iv_charcfromnumericvalue = '33'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '-100'
                                                                        iv_charcfromnumericvalue = '-100'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcvalue            = '95'
                                                                        iv_charcfromnumericvalue = '95'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.

  METHOD atcod2_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '17'
                                                                        iv_charctonumericvalue   = '26'
                                                                        iv_charcvaluedependency  = '2'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive against atcod 2
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '8'
                                                                     iv_charctonumericvalue   = '10'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 2' ).

    " positive against atcod 3
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '17'
                                                                     iv_charctonumericvalue   = '19'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 3' ).


    " positive against atcod 4
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '28'
                                                                     iv_charctonumericvalue   = '30'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 4' ).

    " positive against atcod 5
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '33'
                                                                     iv_charctonumericvalue   = '35'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 5' ).

    " positive against atcod 6
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-199'
                                                                     iv_charctonumericvalue   = '-5'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 6' ).

    " positive against atcod 7
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-199'
                                                                     iv_charctonumericvalue   = '1'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 7' ).

    " positive against atcod 8
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '199'
                                                                     iv_charctonumericvalue   = '200'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 8' ).

    " positive against atcod 9
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '99'
                                                                     iv_charctonumericvalue   = '100'
                                                                     iv_charcvaluedependency  = '2'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 9' ).
  ENDMETHOD.

  METHOD atcod3_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " negative test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '17'
                                                                        iv_charctonumericvalue   = '26'
                                                                        iv_charcvaluedependency  = '3'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive test against atcod 2
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '7'
                                                                     iv_charctonumericvalue   = '9'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 2' ).

    " positive test against atcod 3
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '17'
                                                                     iv_charctonumericvalue   = '19'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 3' ).

    " positive test against atcod 4
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '28'
                                                                     iv_charctonumericvalue   = '29'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 4' ).

    " positive test against atcod 5
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '33'
                                                                     iv_charctonumericvalue   = '35'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 5' ).

    " positive test against atcod 6
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-5'
                                                                     iv_charctonumericvalue   = '-1'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 6' ).

    " positive test against atcod 7
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-5'
                                                                     iv_charctonumericvalue   = '1'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 7' ).

    " positive test against atcod 8
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '101'
                                                                     iv_charctonumericvalue   = '999'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 8' ).

    " positive test against atcod 9
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '90'
                                                                     iv_charctonumericvalue   = '99'
                                                                     iv_charcvaluedependency  = '3'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 9' ).
  ENDMETHOD.

  METHOD atcod4_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " negative test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '17'
                                                                        iv_charctonumericvalue   = '26'
                                                                        iv_charcvaluedependency  = '4'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive test against atcod 2
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '7'
                                                                     iv_charctonumericvalue   = '10'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 2' ).

    " positive test against atcod 3
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '17'
                                                                     iv_charctonumericvalue   = '19'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 3' ).

    " positive test against atcod 4
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '27'
                                                                     iv_charctonumericvalue   = '30'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 4' ).

    " positive test against atcod 5
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '32'
                                                                     iv_charctonumericvalue   = '35'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 5' ).

    " positive test against atcod 6
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-5'
                                                                     iv_charctonumericvalue   = '0'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 6' ).

    " positive test against atcod 7
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-5'
                                                                     iv_charctonumericvalue   = '1'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 7' ).

    " positive test against atcod 8
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '100'
                                                                     iv_charctonumericvalue   = '199'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 8' ).

    " positive test against atcod 9
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '91'
                                                                     iv_charctonumericvalue   = '199'
                                                                     iv_charcvaluedependency  = '4'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 9' ).
  ENDMETHOD.

  METHOD atcod5_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " negative test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '17'
                                                                        iv_charctonumericvalue   = '26'
                                                                        iv_charcvaluedependency  = '5'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive test against atcod 2
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '7'
                                                                     iv_charctonumericvalue   = '9'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned atcod 2' ).

    " positive test against atcod 3
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '17'
                                                                     iv_charctonumericvalue   = '19'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 3' ).

    " positive test against atcod 4
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '27'
                                                                     iv_charctonumericvalue   = '29.5'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned atcod 4' ).

    " positive test against atcod 5
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '32'
                                                                     iv_charctonumericvalue   = '35'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned atcod 5' ).

    " positive test against atcod 6
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-80'
                                                                     iv_charctonumericvalue   = '-1'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned atcod 6' ).

    " positive test against atcod 7
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-8'
                                                                     iv_charctonumericvalue   = '1'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned atcod 7' ).

    " positive test against atcod 8
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '100'
                                                                     iv_charctonumericvalue   = '999'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned atcod 8' ).

    " positive test against atcod 9
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '91'
                                                                     iv_charctonumericvalue   = '999'
                                                                     iv_charcvaluedependency  = '5'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned atcod 9' ).
  ENDMETHOD.

  METHOD atcod6_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " negative test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '17'
                                                                        iv_charcvaluedependency  = '6'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive test against atcod 6
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '0'
                                                                     iv_charcvaluedependency  = '6'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 6' ).

    " positive test against atcod 7
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '1'
                                                                     iv_charcvaluedependency  = '6'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 7' ).

  ENDMETHOD.

  METHOD atcod7_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " negative test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '2'
                                                                        iv_charcvaluedependency  = '7'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive test against atcod 6
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '-1'
                                                                     iv_charcvaluedependency  = '7'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 6' ).

    " positive test against atcod 7
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '1'
                                                                     iv_charcvaluedependency  = '7'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned against atcod 7' ).

  ENDMETHOD.

  METHOD atcod8_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " negative test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '88'
                                                                        iv_charcvaluedependency  = '8'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive test
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '150'
                                                                     iv_charcvaluedependency  = '8'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.

  METHOD atcod9_cstic.

    DATA: ls_expected_msg TYPE ngcs_classification_msg.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " negative test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub(
                                                                        iv_charcfromnumericvalue = '89'
                                                                        iv_charcvaluedependency  = '9'
                                                                        iv_charcdatatype         = 'NUM' ) ).

    assert_error_message( lo_clf_api_result ).

    " positive test
    lo_clf_api_result = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                               io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                               io_classification = get_classification_stub(
                                                                     iv_charcfromnumericvalue = '90'
                                                                     iv_charcvaluedependency  = '9'
                                                                     iv_charcdatatype         = 'NUM' ) ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.


  METHOD assert_error_message.

    READ TABLE io_clf_api_result->get_messages( ) INTO DATA(ls_result) WITH KEY
      msgty            = 'E'
      msgid            = 'NGC_API_BASE'
      msgno            = '012'
      object_key       = lth_ngc_clf_val_charcval_doma=>gc_object_key_one
      technical_object = lth_ngc_clf_val_charcval_doma=>gc_technical_object
      key_date         = lth_ngc_clf_val_charcval_doma=>gc_key_date.

    cl_abap_unit_assert=>assert_not_initial( act = io_clf_api_result->get_messages( )
                                             msg = 'Expected message was not returned' ).

    cl_abap_unit_assert=>assert_not_initial(
      act = ls_result
      msg = 'Expected message was not returned' ).

  ENDMETHOD.

  METHOD get_classification_empty_stub.

    ro_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).
    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters( )->returning(
      VALUE ngcs_classification_key(
        object_key       = lth_ngc_clf_val_charcval_doma=>gc_object_key_one
        technical_object = lth_ngc_clf_val_charcval_doma=>gc_technical_object
        key_date         = lth_ngc_clf_val_charcval_doma=>gc_key_date
        change_number    = space ) ).
    ro_classification->get_classification_key( ).

  ENDMETHOD.

  METHOD get_classification_stub.

    ro_classification = get_classification_empty_stub( ).

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
    )->set_parameter(
      name  = 'et_classification_data_upd'
      value = VALUE ngct_classification_data_upd( ( classinternalid = lth_ngc_clf_val_charcval_doma=>gc_classinternalid ) )
    )->set_parameter(
      name  = 'et_assigned_class_upd'
      value = VALUE ngct_class_object_upd( (
        classinternalid = lth_ngc_clf_val_charcval_doma=>gc_classinternalid
        key_date        = lth_ngc_clf_val_charcval_doma=>gc_key_date
        class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid   = lth_ngc_clf_val_charcval_doma=>gc_classinternalid
                                                    classtype         = lth_ngc_clf_val_charcval_doma=>gc_classtype
                                                    class             = lth_ngc_clf_val_charcval_doma=>gc_class
                                                    validitystartdate = lth_ngc_clf_val_charcval_doma=>gc_key_date + 10
                                                    validityenddate   = lth_ngc_clf_val_charcval_doma=>gc_key_date + 20 ) )
        object_state    = if_ngc_c=>gc_object_state-created ) )
    )->set_parameter(
      name  = 'et_valuation_data_upd'
      value = VALUE ngct_valuation_data_upd( (
          charcinternalid       = lth_ngc_clf_val_charcval_doma=>gc_charcinternalid
          classtype             = lth_ngc_clf_val_charcval_doma=>gc_classtype
          charcvalue            = iv_charcvalue
          charcfromnumericvalue = iv_charcfromnumericvalue
          charctonumericvalue   = iv_charctonumericvalue
          charcvaluedependency  = iv_charcvaluedependency
          object_state          = if_ngc_c=>gc_object_state-updated
        ) )
    ).
    ro_classification->get_updated_data( ).

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
    )->set_parameter(
      name  = 'et_characteristic'
      value = VALUE ngct_clf_characteristic_object(
        ( classtype             = lth_ngc_clf_val_charcval_doma=>gc_classtype
          charcinternalid       = lth_ngc_clf_val_charcval_doma=>gc_charcinternalid
          key_date              = lth_ngc_clf_val_charcval_doma=>gc_key_date
          characteristic_object = NEW ltd_ngc_chr( VALUE #( charcdatatype = iv_charcdatatype ) ) ) )
    ).
    ro_classification->get_characteristics( ).

    IF iv_charcdatatype = 'CHAR'.
      DATA(lt_domain_values) = VALUE ngct_characteristic_value(
        ( charcvaluedependency  = '1'
          charcvalue            = 'CHARC_VALUE' ) ).
    ELSEIF iv_charcdatatype = 'NUM'.
      lt_domain_values = VALUE ngct_characteristic_value(
        ( charcvaluedependency  = '1'
          charcvalue            = '5'
          charcfromnumericvalue = '5')

        ( charcvaluedependency  = '2'
          charcvalue            = '7 - <10'
          charcfromnumericvalue = '7'
          charctonumericvalue   = '10' )

        ( charcvaluedependency  = '3'
          charcvalue            = '15 - 25'
          charcfromnumericvalue = '15'
          charctonumericvalue   = '25' )

        ( charcvaluedependency  = '4'
          charcvalue            = '>27 - <30'
          charcfromnumericvalue = '27'
          charctonumericvalue   = '30' )

        ( charcvaluedependency  = '5'
          charcvalue            = '>32 - 35'
          charcfromnumericvalue = '32'
          charctonumericvalue   = '35' )

        ( charcvaluedependency  = '6'
          charcvalue            = '< 0'
          charcfromnumericvalue = '0' )

        ( charcvaluedependency  = '7'
          charcvalue            = '=< 1'
          charcfromnumericvalue = '1' )

        ( charcvaluedependency  = '8'
          charcvalue            = '100 <'
          charcfromnumericvalue = '100' )

        ( charcvaluedependency  = '9'
          charcvalue            = '90 =<'
          charcfromnumericvalue = '90' )

        ( charcvaluedependency  = '2'
          charcvalue            = '-1999 - <-19988'
          charcfromnumericvalue = '-1999'
          charctonumericvalue   = '-1998' ) ).
    ENDIF.

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
    )->set_parameter(
      name  = 'et_domain_value'
      value = lt_domain_values ).
    ro_classification->get_domain_values(
      EXPORTING
        iv_classtype       = lth_ngc_clf_val_charcval_doma=>gc_classtype
        iv_charcinternalid = lth_ngc_clf_val_charcval_doma=>gc_charcinternalid ).

  ENDMETHOD.

ENDCLASS.