CLASS lth_ngc_clf_validation_mgr DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_technical_object TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_classtype TYPE klassenart VALUE '001'.
ENDCLASS.

CLASS lth_ngc_clf_validation_mgr IMPLEMENTATION.
ENDCLASS.


CLASS ltd_ngc_clf DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_classification PARTIALLY IMPLEMENTED.
    INTERFACES: if_ngc_clf_validation_dp PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_clf IMPLEMENTATION.
  METHOD if_ngc_classification~validate.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~get_validation_class_types.
    rt_classtype = VALUE #( ( lth_ngc_clf_validation_mgr=>gc_classtype ) ).
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~clear_validation_class_types.
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_clf_api_result DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_clf_api_result PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_clf_api_result IMPLEMENTATION.
  METHOD if_ngc_clf_api_result~has_message.
    rv_has_message = abap_true.
  ENDMETHOD.
  METHOD if_ngc_clf_api_result~get_messages.
    rt_message = VALUE #( ( object_key = lth_ngc_clf_validation_mgr=>gc_object_key ) ).
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_clf_dummy_validator DEFINITION.
  PUBLIC SECTION.
    INTERFACES:
      if_ngc_clf_validator.
    METHODS: validate_was_called
      RETURNING VALUE(rv_validate_was_called) TYPE boole_d.
  PRIVATE SECTION.
    DATA: mv_validate_was_called TYPE boole_d VALUE abap_false.
ENDCLASS.

CLASS ltd_ngc_clf_dummy_validator IMPLEMENTATION.
  METHOD if_ngc_clf_validator~validate.
    mv_validate_was_called = abap_true.
  ENDMETHOD.
  METHOD validate_was_called.
    rv_validate_was_called = mv_validate_was_called.
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_clf_dummy_valdtr_fail DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES:
      if_ngc_clf_validator.
    METHODS: validate_was_called
      RETURNING VALUE(rv_validate_was_called) TYPE boole_d.
  PRIVATE SECTION.
    DATA: mv_validate_was_called TYPE boole_d VALUE abap_false.
ENDCLASS.

CLASS ltd_ngc_clf_dummy_valdtr_fail IMPLEMENTATION.
  METHOD if_ngc_clf_validator~validate.
    mv_validate_was_called = abap_true.
    ro_clf_api_result = NEW ltd_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD validate_was_called.
    rv_validate_was_called = mv_validate_was_called.
  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_clf_validation_mgr DEFINITION DEFERRED.
CLASS cl_ngc_clf_validation_mgr DEFINITION LOCAL FRIENDS ltc_ngc_clf_validation_mgr.

CLASS ltc_ngc_clf_validation_mgr DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut             TYPE REF TO cl_ngc_clf_validation_mgr,
      mo_dummy_validator TYPE REF TO ltd_ngc_clf_dummy_validator.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_validators_for_class_type FOR TESTING.
    METHODS: validate_empty FOR TESTING.
    METHODS: validate_ok FOR TESTING.
    METHODS: validate_fail FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_clf_validation_mgr IMPLEMENTATION.

  METHOD class_setup.

  ENDMETHOD.


  METHOD class_teardown.

  ENDMETHOD.


  METHOD setup.
    mo_cut = cl_ngc_clf_validation_mgr=>get_instance( ).
    mo_dummy_validator = NEW ltd_ngc_clf_dummy_validator( ).
    mo_cut->mt_validator = VALUE #( ( sort = 10 validator = mo_dummy_validator ) ).
  ENDMETHOD.


  METHOD teardown.

  ENDMETHOD.


  METHOD get_validators_for_class_type.

    DATA: lo_dummy_validator TYPE REF TO ltd_ngc_clf_dummy_validator.

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validation manager instance is not bound' ).

    DATA(lt_validators) = mo_cut->get_validators_for_class_type( iv_classtype = lth_ngc_clf_validation_mgr=>gc_classtype ).

    cl_abap_unit_assert=>assert_equals( act = lines( lt_validators )
                                        exp = 1
                                        msg = 'GET_VALIDATORS_FOR_CLASS_TYPE returned unexpected result' ).

    cl_abap_unit_assert=>assert_equals( act = lt_validators[ 1 ]-sort
                                        exp = 10
                                        msg = 'GET_VALIDATORS_FOR_CLASS_TYPE returned unexpected result' ).

    cl_abap_unit_assert=>assert_bound( act = lt_validators[ 1 ]-validator
                                       msg = 'GET_VALIDATORS_FOR_CLASS_TYPE returned unexpected result' ).

    TRY.
        lo_dummy_validator ?= lt_validators[ 1 ]-validator.
      CATCH cx_sy_move_cast_error.
        cl_abap_unit_assert=>fail( msg = 'GET_VALIDATORS_FOR_CLASS_TYPE returned unexpected result' ).
    ENDTRY.

  ENDMETHOD.


  METHOD validate_empty.

    DATA: lo_ngc_classification TYPE REF TO if_ngc_classification.

    mo_cut->validate(
      EXPORTING
        io_classification = lo_ngc_classification
*       it_classification_data =
*       it_assigned_classes    =
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result) ).

    cl_abap_unit_assert=>assert_not_bound( act = lo_clf_api_result
                                           msg = 'Validate returned with unexpected result' ).

    cl_abap_unit_assert=>assert_false( act = mo_dummy_validator->validate_was_called( )
                                       msg = 'Validate returned with unexpected result' ).

  ENDMETHOD.


  METHOD validate_ok.

    mo_cut->validate(
      EXPORTING
        io_classification = NEW ltd_ngc_clf( )
*       it_classification_data =
*       it_assigned_classes    =
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'Validate returned with unexpected result' ).

    cl_abap_unit_assert=>assert_true( act = mo_dummy_validator->validate_was_called( )
                                      msg = 'Validate returned with unexpected result' ).

  ENDMETHOD.


  METHOD validate_fail.

    DATA(lo_validator_fail) = NEW ltd_ngc_clf_dummy_valdtr_fail( ).

    mo_cut->mt_validator = VALUE #( ( sort = 10 validator = lo_validator_fail ) ).

    mo_cut->validate(
      EXPORTING
        io_classification = NEW ltd_ngc_clf( )
*       it_classification_data =
*       it_assigned_classes    =
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'Validate returned with unexpected result' ).

    cl_abap_unit_assert=>assert_not_initial( act = lo_clf_api_result->get_messages( )
                                             msg = 'Validate returned with unexpected result' ).

    cl_abap_unit_assert=>assert_true( act = lo_validator_fail->validate_was_called( )
                                      msg = 'Validate returned with unexpected result' ).

  ENDMETHOD.

ENDCLASS.