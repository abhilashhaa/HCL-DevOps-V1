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
  METHOD if_ngc_class~get_characteristics ##NEEDED.
  ENDMETHOD.
ENDCLASS.


CLASS lth_ngc_clf_val_class_status DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_one TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_technical_object TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_classtype TYPE klassenart VALUE '001'.
    CONSTANTS: gc_another_classtype TYPE klassenart VALUE '002'.
    CONSTANTS: gc_classinternalid TYPE clint VALUE '1'.
    CONSTANTS: gc_classstatusname TYPE eintext VALUE 'Rel'.
    CONSTANTS: gc_class TYPE klasse_d VALUE 'CLASS'.
ENDCLASS.

CLASS lth_ngc_clf_val_class_status IMPLEMENTATION.
ENDCLASS.

CLASS ltd_ngc_clf_validation_dp DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_clf_validation_dp PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_clf_validation_dp IMPLEMENTATION.
  METHOD if_ngc_clf_validation_dp~set_updated_data ##NEEDED.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_clf_val_class_status DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_class_status DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_class_status.

CLASS ltc_ngc_clf_val_class_status DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_val_class_status.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: no_clf FOR TESTING.
    METHODS: clf_allowed FOR TESTING.
    METHODS: clf_not_allowed FOR TESTING.
    METHODS: wrong_classtype FOR TESTING.
    METHODS: assert_error_message
      IMPORTING
        it_messages TYPE ngct_classification_msg.
    METHODS: get_classification_stub
      IMPORTING
                iv_has_assigned_classes      TYPE boole_d DEFAULT abap_false
                iv_classification_is_allowed TYPE boole_d DEFAULT abap_false
      RETURNING VALUE(ro_classification)     TYPE REF TO if_ngc_classification.
ENDCLASS.


CLASS ltc_ngc_clf_val_class_status IMPLEMENTATION.

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

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_class_status=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.


  METHOD clf_allowed.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_class_status=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( iv_has_assigned_classes      = abap_true
                                                                                                                  iv_classification_is_allowed = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).


  ENDMETHOD.


  METHOD clf_not_allowed.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_class_status=>gc_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( iv_has_assigned_classes      = abap_true
                                                                                                                  iv_classification_is_allowed = abap_false ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    assert_error_message( lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD wrong_classtype.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_class_status=>gc_another_classtype
                                                                     io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
                                                                     io_classification = get_classification_stub( iv_has_assigned_classes      = abap_true
                                                                                                                  iv_classification_is_allowed = abap_false ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.

  METHOD get_classification_stub.

    ro_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    IF iv_has_assigned_classes = abap_true.
      cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
        )->set_parameter(
          name  = 'et_classification_data_upd'
          value = VALUE ngct_classification_data_upd( ( classinternalid = lth_ngc_clf_val_class_status=>gc_classinternalid ) )
        )->set_parameter(
          name  = 'et_assigned_class_upd'
          value = VALUE ngct_class_object_upd( ( classinternalid = lth_ngc_clf_val_class_status=>gc_classinternalid
                                              key_date        = lth_ngc_clf_val_class_status=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid         = lth_ngc_clf_val_class_status=>gc_classinternalid
                                                                                          classtype               = lth_ngc_clf_val_class_status=>gc_classtype
                                                                                          class                   = lth_ngc_clf_val_class_status=>gc_class
                                                                                          classstatusname         = lth_ngc_clf_val_class_status=>gc_classstatusname
                                                                                          classificationisallowed = iv_classification_is_allowed ) )
                                              object_state    = if_ngc_c=>gc_object_state-created ) )
        ).
      ro_classification->get_updated_data( ).
    ENDIF.

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters( )->returning(
      VALUE ngcs_classification_key(
        object_key       = lth_ngc_clf_val_class_status=>gc_object_key_one
        technical_object = lth_ngc_clf_val_class_status=>gc_technical_object
        key_date         = lth_ngc_clf_val_class_status=>gc_key_date
        change_number    = space ) ).
    ro_classification->get_classification_key( ).

  ENDMETHOD.

  METHOD assert_error_message.
    MESSAGE e001(ngc_api_base) WITH lth_ngc_clf_val_class_status=>gc_classtype lth_ngc_clf_val_class_status=>gc_classstatusname lth_ngc_clf_val_class_status=>gc_class INTO DATA(lv_msg) ##NEEDED.
    READ TABLE it_messages TRANSPORTING NO FIELDS WITH KEY object_key       = lth_ngc_clf_val_class_status=>gc_object_key_one
                                                           technical_object = lth_ngc_clf_val_class_status=>gc_technical_object
                                                           key_date         = lth_ngc_clf_val_class_status=>gc_key_date
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