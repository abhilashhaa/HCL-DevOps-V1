*"* use this source file for your ABAP unit test classes

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


CLASS lth_ngc_clf_val_ecn_classtype DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_one TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_technical_object TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_change_number_with_clf TYPE aennr VALUE 'ECN_CLF'. " ECN with CLF support
    CONSTANTS: gc_change_number_without_clf TYPE aennr VALUE 'ECN_NO_CLF'. " ECN without CLF support
    CONSTANTS: gc_classtype_with_ecn_supp TYPE klassenart VALUE '001'.
    CONSTANTS: gc_classtype_without_ecn_supp TYPE klassenart VALUE '002'.
    CONSTANTS: gc_classinternalid TYPE clint VALUE '1'.
ENDCLASS.

CLASS lth_ngc_clf_val_ecn_classtype IMPLEMENTATION.
ENDCLASS.


CLASS ltd_ngc_clf_persistency DEFINITION FINAL INHERITING FROM cl_ngc_core_clf_persistency.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_testdouble_instance
        RETURNING VALUE(ro_testdouble_instance) TYPE REF TO cl_ngc_core_clf_persistency.
    METHODS: if_ngc_core_clf_persistency~read_classtype REDEFINITION.
    METHODS: constructor.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_ngc_clf_persistency IMPLEMENTATION.
  METHOD get_testdouble_instance.
    ro_testdouble_instance = NEW ltd_ngc_clf_persistency( ).
  ENDMETHOD.
  METHOD constructor.
    super->constructor(
      io_util            = VALUE #( )
      io_db_update       = VALUE #( )
      io_locking         = VALUE #( )
      io_bte             = VALUE #( )
      io_cls_persistency = VALUE #( )
    ).
  ENDMETHOD.
  METHOD if_ngc_core_clf_persistency~read_classtype.
    IF iv_clfnobjecttable = lth_ngc_clf_val_ecn_classtype=>gc_technical_object.
      rs_classtype = VALUE #( classtype                     = iv_classtype
                              clfnobjecttable               = iv_clfnobjecttable
                              language                      = 'E'
                              classtypename                 = iv_classtype
                              multipleobjtableclfnisallowed = abap_false
                              engchangemgmtisallowed        = COND #( WHEN iv_classtype = lth_ngc_clf_val_ecn_classtype=>gc_classtype_without_ecn_supp THEN abap_false
                                                                      ELSE abap_true )
                              multipleclassisallowed        = abap_false ).
    ENDIF.
  ENDMETHOD.
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

CLASS ltd_ngc_clf_ecn_bo_nonexisting DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: lif_ngc_core_clf_ecn_bo.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_ngc_clf_ecn_bo_nonexisting IMPLEMENTATION.
  METHOD lif_ngc_core_clf_ecn_bo~get_ecn.
    CLEAR: es_ecn, et_message, ev_severity.

    ev_severity = 'E'.

    et_message = VALUE #( ( msgid = 'DUMMY'
                            msgty = 'E'
                            msgno = '000'
                            msgv1 = 'P1'
                            msgv2 = 'P1'
                            msgv3 = 'P1'
                            msgv4 = 'P1' ) ).

  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_clf_ecn_bo DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: lif_ngc_core_clf_ecn_bo.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_ngc_clf_ecn_bo IMPLEMENTATION.
  METHOD lif_ngc_core_clf_ecn_bo~get_ecn.

    CLEAR: es_ecn, et_message, ev_severity.

    es_ecn = VALUE #( change_no  = iv_change_no
                      valid_from = lth_ngc_clf_val_ecn_classtype=>gc_key_date
                      obj_type   = COND #( WHEN iv_change_no = lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf THEN VALUE #( ( obj_cat = if_ngc_c=>gc_obj_clf_ecn_obj_type active = abap_true ) )
                                           ELSE VALUE #( ) ) ).

  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_clf_val_ecn_classtype DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_ecn_classtype DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_ecn_classtype.

CLASS ltc_ngc_clf_val_ecn_classtype DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_val_ecn_classtype.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: no_clf_classtype_ecn_supp FOR TESTING.
    METHODS: no_clf_classtype_no_ecn_supp FOR TESTING.
    METHODS: clf_classtype_ecn_supp FOR TESTING.
    METHODS: clf_classtype_no_ecn_supp FOR TESTING.
    METHODS: no_clf_ecn_no_clf_supp FOR TESTING.
    METHODS: wrong_classtype FOR TESTING.
    METHODS: no_ecn FOR TESTING.
    METHODS: nonexisting_ecn FOR TESTING.
*    METHODS: assert_warning_ecn_ignored
*      IMPORTING
*        iv_change_number TYPE aennr
*        it_messages      TYPE ngct_classification_msg.
    METHODS: assert_error_classtype_no_ecn
      IMPORTING
        iv_change_number TYPE aennr
        iv_classtype     TYPE klassenart
        it_messages      TYPE ngct_classification_msg.
    METHODS: assert_error_ecn_no_clf
      IMPORTING
        iv_change_number TYPE aennr
        it_messages      TYPE ngct_classification_msg.
    METHODS: get_classification_stub_ecn
      IMPORTING
                iv_has_assigned_classes  TYPE boole_d DEFAULT abap_false
                iv_classtype_ecn_support TYPE boole_d DEFAULT abap_false
                iv_ecn_clf_support       TYPE boole_d DEFAULT abap_false
      RETURNING VALUE(ro_classification) TYPE REF TO if_ngc_classification.
    METHODS: get_classification_stub_no_ecn
      RETURNING VALUE(ro_classification) TYPE REF TO if_ngc_classification.

ENDCLASS.


CLASS ltc_ngc_clf_val_ecn_classtype IMPLEMENTATION.

  METHOD class_setup.

  ENDMETHOD.


  METHOD class_teardown.

  ENDMETHOD.


  METHOD setup.

  ENDMETHOD.


  METHOD teardown.

  ENDMETHOD.


  METHOD no_clf_classtype_ecn_supp.

    " No classes assigned. ECN supported by class type. Warning should appear about ignoring the ECN.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_with_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_ecn( iv_classtype_ecn_support = abap_true
                                                                                                                          iv_ecn_clf_support       = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

*    assert_warning_ecn_ignored( iv_change_number = lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf
*                                it_messages      = lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD no_clf_classtype_no_ecn_supp.

    " No classes assigned. No ECN supported by class type. Warning should appear about ignoring the ECN.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_without_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_ecn( iv_ecn_clf_support = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

*    assert_warning_ecn_ignored( iv_change_number = lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf
*                                it_messages      = lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD clf_classtype_ecn_supp.

    " Classes assigned. ECN supported by class type. Warning should appear about ignoring the ECN.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_with_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_ecn( iv_classtype_ecn_support = abap_true
                                                                                                                      iv_has_assigned_classes  = abap_true
                                                                                                                      iv_ecn_clf_support       = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

*    assert_warning_ecn_ignored( iv_change_number = lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf
*                                it_messages      = lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD clf_classtype_no_ecn_supp.

    " Classes assigned. No ECN supported by class type. Warning should appear about ignoring the ECN.

    DATA: lr_class_key TYPE REF TO ngcs_class_key.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_without_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_ecn( iv_classtype_ecn_support = abap_false
                                                                                                                      iv_has_assigned_classes  = abap_true
                                                                                                                      iv_ecn_clf_support       = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    DATA(lt_messages) = lo_clf_api_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals( act = lines( lt_messages )
                                        exp = 1
                                        msg = 'Unexpected messages were returned' ).

    assert_error_classtype_no_ecn( iv_change_number = lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf
                                   iv_classtype     = lth_ngc_clf_val_ecn_classtype=>gc_classtype_without_ecn_supp
                                   it_messages      = lt_messages ).

  ENDMETHOD.


  METHOD no_clf_ecn_no_clf_supp.

    " No classes assigned. No ECN supported by class type. Warning should appear about ignoring the ECN.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_with_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_ecn( iv_classtype_ecn_support = abap_true
                                                                                                                      iv_ecn_clf_support       = abap_false ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    DATA(lt_messages) = lo_clf_api_result->get_messages( ).

    " build expected message
    cl_abap_unit_assert=>assert_equals( act = lines( lt_messages )
                                        exp = 1
                                        msg = 'Unexpected messages were returned' ).

    assert_error_ecn_no_clf( iv_change_number = lth_ngc_clf_val_ecn_classtype=>gc_change_number_without_clf
                             it_messages      = lt_messages ).

  ENDMETHOD.


  METHOD wrong_classtype.

    " Classes are assigned. No ECN supported by class type.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_with_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_ecn( iv_has_assigned_classes  = abap_true
                                                                                                                      iv_classtype_ecn_support = abap_false
                                                                                                                      iv_ecn_clf_support       = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

*    assert_warning_ecn_ignored( iv_change_number = lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf
*                                it_messages      = lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD no_ecn.

    " No classes assigned. No ECN provided in the key for the classification.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_with_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_no_ecn( ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages werer returned' ).


  ENDMETHOD.


  METHOD nonexisting_ecn.

    " No classes assigned. No ECN provided in the key for the classification.

    mo_cut = NEW #( ).

    mo_cut->mo_ecn_bo = NEW ltd_ngc_clf_ecn_bo_nonexisting( ).
    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_ecn_classtype=>gc_classtype_with_ecn_supp
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub_ecn( iv_has_assigned_classes  = abap_true
                                                                                                                      iv_classtype_ecn_support = abap_false
                                                                                                                      iv_ecn_clf_support       = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

*    assert_warning_ecn_ignored( iv_change_number = lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf
*                                it_messages      = lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


*  METHOD assert_warning_ecn_ignored.
*    MESSAGE w004(ngc_api_base) WITH iv_change_number INTO DATA(lv_msg).
*    READ TABLE it_messages TRANSPORTING NO FIELDS WITH KEY object_key       = lth_ngc_clf_val_ecn_classtype=>gc_object_key_one
*                                                           technical_object = lth_ngc_clf_val_ecn_classtype=>gc_technical_object
*                                                           key_date         = lth_ngc_clf_val_ecn_classtype=>gc_key_date
*                                                           change_number    = iv_change_number
*                                                           msgid            = sy-msgid
*                                                           msgty            = sy-msgty
*                                                           msgno            = sy-msgno
*                                                           msgv1            = sy-msgv1
*                                                           msgv2            = sy-msgv2
*                                                           msgv3            = sy-msgv3
*                                                           msgv4            = sy-msgv4.
*    cl_abap_unit_assert=>assert_initial( act = sy-subrc
*                                         msg = 'Unexpected messages were returned' ).
*  ENDMETHOD.

  METHOD get_classification_stub_ecn.

    ro_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    IF iv_has_assigned_classes = abap_true.
      cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
        )->set_parameter(
          name  = 'et_classification_data_upd'
          value = VALUE ngct_classification_data_upd( ( classinternalid = lth_ngc_clf_val_ecn_classtype=>gc_classinternalid ) )
        )->set_parameter(
          name  = 'et_assigned_class_upd'
          value = VALUE ngct_class_object_upd( (
                                              classinternalid = lth_ngc_clf_val_ecn_classtype=>gc_classinternalid
                                              key_date        = lth_ngc_clf_val_ecn_classtype=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid = lth_ngc_clf_val_ecn_classtype=>gc_classinternalid
                                                                                          classtype       = COND #( WHEN iv_classtype_ecn_support = abap_true THEN lth_ngc_clf_val_ecn_classtype=>gc_classtype_with_ecn_supp
                                                                                                                    ELSE lth_ngc_clf_val_ecn_classtype=>gc_classtype_without_ecn_supp ) ) )
                                              object_state    = if_ngc_c=>gc_object_state-created ) )
        ).
      ro_classification->get_updated_data( ).
    ENDIF.

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters( )->returning(
      VALUE ngcs_classification_key(
        object_key       = lth_ngc_clf_val_ecn_classtype=>gc_object_key_one
        technical_object = lth_ngc_clf_val_ecn_classtype=>gc_technical_object
        key_date         = lth_ngc_clf_val_ecn_classtype=>gc_key_date
        change_number    = COND #( WHEN iv_ecn_clf_support = abap_true THEN lth_ngc_clf_val_ecn_classtype=>gc_change_number_with_clf
                                   ELSE lth_ngc_clf_val_ecn_classtype=>gc_change_number_without_clf ) ) ).
    ro_classification->get_classification_key( ).

  ENDMETHOD.

  METHOD get_classification_stub_no_ecn.

    ro_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters( )->returning(
      VALUE ngcs_classification_key(
        object_key       = lth_ngc_clf_val_ecn_classtype=>gc_object_key_one
        technical_object = lth_ngc_clf_val_ecn_classtype=>gc_technical_object
        key_date         = lth_ngc_clf_val_ecn_classtype=>gc_key_date
        change_number    = space ) ).
    ro_classification->get_classification_key( ).

  ENDMETHOD.

  METHOD assert_error_classtype_no_ecn.
    MESSAGE e003(ngc_api_base) WITH iv_classtype INTO DATA(lv_msg).
    READ TABLE it_messages TRANSPORTING NO FIELDS WITH KEY object_key       = lth_ngc_clf_val_ecn_classtype=>gc_object_key_one
                                                           technical_object = lth_ngc_clf_val_ecn_classtype=>gc_technical_object
                                                           key_date         = lth_ngc_clf_val_ecn_classtype=>gc_key_date
                                                           change_number    = iv_change_number
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

  METHOD assert_error_ecn_no_clf.
    MESSAGE e002(ngc_api_base) WITH iv_change_number INTO DATA(lv_msg).
    READ TABLE it_messages TRANSPORTING NO FIELDS WITH KEY object_key       = lth_ngc_clf_val_ecn_classtype=>gc_object_key_one
                                                           technical_object = lth_ngc_clf_val_ecn_classtype=>gc_technical_object
                                                           key_date         = lth_ngc_clf_val_ecn_classtype=>gc_key_date
                                                           change_number    = iv_change_number
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