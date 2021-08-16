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


CLASS lth_ngc_clf_val_positionnumber DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_one TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_technical_object TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_classtype TYPE klassenart VALUE '001'.
    CONSTANTS: gc_classtype_nonexisting TYPE klassenart VALUE 'ZZZ'.
    CONSTANTS: gc_classinternalid TYPE clint VALUE '1'.
    CONSTANTS: gc_second_classinternalid TYPE clint VALUE '2'.
    CONSTANTS: gc_another_classinternalid TYPE clint VALUE '3'.
    CONSTANTS: gc_classstatusname TYPE eintext VALUE 'Rel'.
    CONSTANTS: gc_class TYPE klasse_d VALUE 'CLASS'.
    CONSTANTS: gc_second_class TYPE klasse_d VALUE 'CLASS2'.
    CONSTANTS: gc_another_class TYPE klasse_d VALUE 'ANOTHER_CLASS'.
ENDCLASS.

CLASS lth_ngc_clf_val_positionnumber IMPLEMENTATION.
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

    CLEAR: rs_classtype.

    IF iv_classtype = lth_ngc_clf_val_positionnumber=>gc_classtype_nonexisting.
      RETURN.
    ENDIF.

    IF iv_clfnobjecttable = lth_ngc_clf_val_positionnumber=>gc_technical_object.
      rs_classtype = VALUE #( classtype                     = iv_classtype
                              clfnobjecttable               = iv_clfnobjecttable
                              language                      = 'E'
                              classtypename                 = iv_classtype
                              multipleobjtableclfnisallowed = abap_false
                              engchangemgmtisallowed        = abap_false
                              multipleclassisallowed        = COND #( WHEN iv_classtype = lth_ngc_clf_val_positionnumber=>gc_classtype THEN abap_true
                                                                      ELSE abap_false ) ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_clf_classification DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES:
      if_ngc_classification PARTIALLY IMPLEMENTED,
      if_ngc_clf_validation_dp PARTIALLY IMPLEMENTED.
    METHODS: constructor
      IMPORTING
        iv_number_of_assigned_classes TYPE int4 DEFAULT 0.
  PRIVATE SECTION.
    DATA: mt_classification_data_upd TYPE ngct_classification_data_upd.
    DATA: mt_assigned_classes_upd TYPE ngct_class_object_upd.
ENDCLASS.

CLASS ltd_ngc_clf_classification IMPLEMENTATION.
  METHOD constructor.
    IF iv_number_of_assigned_classes = 1.
      mt_classification_data_upd = VALUE #( ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_classinternalid
                                              classpositionnumber = 20
                                              object_state    = if_ngc_c=>gc_object_state-created )
                                            ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid
                                              classpositionnumber = 0
                                              object_state    = if_ngc_c=>gc_object_state-created ) ).
      mt_assigned_classes_upd    = VALUE #( ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_classinternalid
                                              key_date        = lth_ngc_clf_val_positionnumber=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid         = lth_ngc_clf_val_positionnumber=>gc_classinternalid
                                                                                          classtype               = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                                          class                   = lth_ngc_clf_val_positionnumber=>gc_another_class
                                                                                          classstatusname         = lth_ngc_clf_val_positionnumber=>gc_classstatusname
                                                                                          classificationisallowed = abap_true ) )
                                              object_state    = if_ngc_c=>gc_object_state-created )
                                            ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid
                                              key_date        = lth_ngc_clf_val_positionnumber=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid         = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid
                                                                                          classtype               = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                                          class                   = lth_ngc_clf_val_positionnumber=>gc_another_class
                                                                                          classstatusname         = lth_ngc_clf_val_positionnumber=>gc_classstatusname
                                                                                          classificationisallowed = abap_true ) )
                                              object_state    = if_ngc_c=>gc_object_state-created ) ).
    ELSEIF iv_number_of_assigned_classes = 2.
      mt_classification_data_upd = VALUE #( ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_classinternalid
                                              classpositionnumber = 20
                                              object_state    = if_ngc_c=>gc_object_state-created )
                                            ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_second_classinternalid
                                              classpositionnumber = 30
                                              object_state    = if_ngc_c=>gc_object_state-created )
                                            ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid
                                              classpositionnumber = 0
                                              object_state    = if_ngc_c=>gc_object_state-created ) ).
      mt_assigned_classes_upd    = VALUE #( ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_classinternalid
                                              key_date        = lth_ngc_clf_val_positionnumber=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid         = lth_ngc_clf_val_positionnumber=>gc_classinternalid
                                                                                          classtype               = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                                          class                   = lth_ngc_clf_val_positionnumber=>gc_class
                                                                                          classstatusname         = lth_ngc_clf_val_positionnumber=>gc_classstatusname
                                                                                          classificationisallowed = abap_true ) )
                                              object_state    = if_ngc_c=>gc_object_state-created )
                                            ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_second_classinternalid
                                              key_date        = lth_ngc_clf_val_positionnumber=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid         = lth_ngc_clf_val_positionnumber=>gc_second_classinternalid
                                                                                          classtype               = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                                          class                   = lth_ngc_clf_val_positionnumber=>gc_second_class
                                                                                          classstatusname         = lth_ngc_clf_val_positionnumber=>gc_classstatusname
                                                                                          classificationisallowed = abap_true ) )
                                              object_state    = if_ngc_c=>gc_object_state-created )
                                            ( classinternalid = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid
                                              key_date        = lth_ngc_clf_val_positionnumber=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( VALUE #( classinternalid         = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid
                                                                                          classtype               = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                                          class                   = lth_ngc_clf_val_positionnumber=>gc_another_class
                                                                                          classstatusname         = lth_ngc_clf_val_positionnumber=>gc_classstatusname
                                                                                          classificationisallowed = abap_true ) )
                                              object_state    = if_ngc_c=>gc_object_state-created ) ).
    ENDIF.
  ENDMETHOD.
  METHOD if_ngc_classification~get_classification_key.
    rs_classification_key = VALUE #( object_key       = lth_ngc_clf_val_positionnumber=>gc_object_key_one
                                     technical_object = lth_ngc_clf_val_positionnumber=>gc_technical_object
                                     key_date         = lth_ngc_clf_val_positionnumber=>gc_key_date
                                     change_number    = space ).
  ENDMETHOD.
  METHOD if_ngc_classification~get_updated_data.
    CLEAR: et_assigned_class_upd, et_classification_data_upd.
    et_assigned_class_upd      = mt_assigned_classes_upd.
    et_classification_data_upd = mt_classification_data_upd.
  ENDMETHOD.
  METHOD if_ngc_classification~get_assigned_classes.
    DATA: ls_classification_data TYPE ngcs_classification_data.
    LOOP AT mt_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>).
      MOVE-CORRESPONDING <ls_classification_data_upd> TO ls_classification_data.
      ls_classification_data-classtype = lth_ngc_clf_val_positionnumber=>gc_classtype.
      APPEND ls_classification_data TO et_classification_data.
    ENDLOOP.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~set_updated_data.
    IF it_classification_data_upd IS SUPPLIED.
      mt_classification_data_upd = it_classification_data_upd.
    ENDIF.
    IF it_assigned_class_upd IS SUPPLIED.
      mt_assigned_classes_upd = it_assigned_class_upd.
    ENDIF.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~get_validation_class_types ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~update_assigned_values ##NEEDED.
  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_clf_val_positionnumber DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_positionnumber DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_positionnumber.

CLASS ltc_ngc_clf_val_positionnumber DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_val_positionnumber.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: no_clf FOR TESTING.
    METHODS: clf_one_class FOR TESTING.
    METHODS: clf_two_classes FOR TESTING.
    METHODS: wrong_classtype FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_clf_val_positionnumber IMPLEMENTATION.

  METHOD class_setup.


  ENDMETHOD.


  METHOD class_teardown.


  ENDMETHOD.


  METHOD setup.


  ENDMETHOD.


  METHOD teardown.


  ENDMETHOD.


  METHOD no_clf.

    DATA lo_validation TYPE REF TO if_ngc_clf_validation_dp.

    DATA(lo_classification) = NEW ltd_ngc_clf_classification( ).

    lo_validation ?= lo_classification.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                     io_data_provider  = lo_validation
                                                                     io_classification = lo_classification ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.


  METHOD clf_one_class.

    DATA lo_validation TYPE REF TO if_ngc_clf_validation_dp.

    DATA(lo_classification) = NEW ltd_ngc_clf_classification( iv_number_of_assigned_classes = 1 ).

    lo_validation ?= lo_classification.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " before calling the method under test, we build up the expected results table
    lo_classification->if_ngc_classification~get_updated_data(
      IMPORTING
        et_classification_data_upd = DATA(lt_classification_data_upd_exp) ).

    READ TABLE lt_classification_data_upd_exp ASSIGNING FIELD-SYMBOL(<ls_clf_data_upd_exp>)
      WITH KEY classinternalid = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid.
    <ls_clf_data_upd_exp>-classpositionnumber = 30.

    " call the method under test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                     io_data_provider  = lo_validation
                                                                     io_classification = lo_classification ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_classification->if_ngc_classification~get_updated_data(
      IMPORTING
        et_classification_data_upd = DATA(lt_classification_data_upd_act) ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_upd_act
                                        exp = lt_classification_data_upd_exp
                                        msg = 'Classification data has not been set properly by the API' ).

  ENDMETHOD.


  METHOD clf_two_classes.

    DATA lo_validation TYPE REF TO if_ngc_clf_validation_dp.

    DATA(lo_classification) = NEW ltd_ngc_clf_classification( iv_number_of_assigned_classes = 2 ).

    lo_validation ?= lo_classification.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    " before calling the method under test, we build up the expected results table
    lo_classification->if_ngc_classification~get_updated_data(
      IMPORTING
        et_classification_data_upd = DATA(lt_classification_data_upd_exp) ).

    READ TABLE lt_classification_data_upd_exp ASSIGNING FIELD-SYMBOL(<ls_clf_data_upd_exp>)
      WITH KEY classinternalid = lth_ngc_clf_val_positionnumber=>gc_another_classinternalid.
    <ls_clf_data_upd_exp>-classpositionnumber = 40.

    " call the method under test
    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_positionnumber=>gc_classtype
                                                                     io_data_provider  = lo_validation
                                                                     io_classification = lo_classification ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

    lo_classification->if_ngc_classification~get_updated_data(
      IMPORTING
        et_classification_data_upd = DATA(lt_classification_data_upd_act) ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_upd_act
                                        exp = lt_classification_data_upd_exp
                                        msg = 'Classification data has not been set properly by the API' ).

  ENDMETHOD.


  METHOD wrong_classtype.

    DATA lo_validation TYPE REF TO if_ngc_clf_validation_dp.

    DATA(lo_classification) = NEW ltd_ngc_clf_classification( iv_number_of_assigned_classes = 1 ).

    lo_validation ?= lo_classification.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate( iv_classtype      = lth_ngc_clf_val_positionnumber=>gc_classtype_nonexisting
                                                                     io_data_provider  = lo_validation
                                                                     io_classification = lo_classification ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.

ENDCLASS.