*"* use this source file for your ABAP unit test classes

CLASS lth_ngc_clf_val_value_used_lea DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_parent       TYPE cuobn VALUE 'TEST1'.
    CONSTANTS: gc_object_key_child        TYPE cuobn VALUE 'TEST1CHILD'.
    CONSTANTS: gc_technical_object_parent TYPE tabelle VALUE 'TEST'.
    CONSTANTS: gc_technical_object_child  TYPE tabelle VALUE 'TESTCHILD'.
    CONSTANTS: gc_classtype               TYPE klassenart VALUE 'PB1'.
    CONSTANTS: gc_description             TYPE atbez VALUE 'TestCharc'.
    CONSTANTS: gc_charcvalue_parent       TYPE atwrt VALUE 'CHARCVAL1'.
    CONSTANTS: gc_charcvalue_child        TYPE atwrt VALUE 'CHARCVAL2'.
ENDCLASS.

CLASS lth_ngc_clf_val_value_used_lea IMPLEMENTATION.
ENDCLASS.


CLASS ltd_ngc_characteristic DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_characteristic PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_characteristic IMPLEMENTATION.
  METHOD if_ngc_characteristic~get_header.
    rs_characteristic_header = VALUE #( charcdescription = lth_ngc_clf_val_value_used_lea=>gc_description ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_clf DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_classification PARTIALLY IMPLEMENTED, if_ngc_clf_validation_dp PARTIALLY IMPLEMENTED.
    METHODS constructor
      IMPORTING
        iv_is_node                  TYPE boole_d
        is_classification_key       TYPE ngcs_classification_key
        it_valuation_data_upd       TYPE ngct_valuation_data_upd
        it_child_classification_key TYPE ngct_classification_key
        it_characteristic           TYPE ngct_clf_characteristic_object.
  PRIVATE SECTION.
    DATA mv_is_node                  TYPE boole_d .
    DATA ms_classification_key       TYPE ngcs_classification_key .
    DATA mt_valuation_data_upd       TYPE ngct_valuation_data_upd .
    DATA mt_child_classification_key TYPE ngct_classification_key .
    DATA mt_characteristic           TYPE ngct_clf_characteristic_object .
ENDCLASS.

CLASS ltd_ngc_clf IMPLEMENTATION.
  METHOD constructor.
    mv_is_node                  = iv_is_node.
    ms_classification_key       = is_classification_key.
    mt_valuation_data_upd       = it_valuation_data_upd.
    mt_child_classification_key = it_child_classification_key.
    mt_characteristic           = it_characteristic.
  ENDMETHOD.
  METHOD if_ngc_classification~get_updated_data.
    CLEAR: et_assigned_class_upd, et_classification_data_upd, et_valuation_data_upd.
    et_valuation_data_upd = mt_valuation_data_upd.
  ENDMETHOD.
  METHOD if_ngc_classification~get_classification_key.
    rs_classification_key = ms_classification_key.
  ENDMETHOD.
  METHOD if_ngc_clf_validation_dp~get_classtype_node_or_leaf.
    CLEAR: es_parent_classification_key, et_child_classification_key, ev_is_node.
    ev_is_node = mv_is_node.
    et_child_classification_key = mt_child_classification_key.
  ENDMETHOD.
  METHOD if_ngc_classification~get_assigned_values.
    CLEAR: eo_clf_api_result, et_valuation_data.
    LOOP AT mt_valuation_data_upd ASSIGNING FIELD-SYMBOL(<ls_valuation_data_upd>).
      APPEND INITIAL LINE TO et_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
      MOVE-CORRESPONDING <ls_valuation_data_upd> TO <ls_valuation_data>.
    ENDLOOP.
  ENDMETHOD.
  METHOD if_ngc_classification~get_characteristics.
    CLEAR: eo_clf_api_result, et_characteristic.
    et_characteristic = mt_characteristic.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_api DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_api PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_api IMPLEMENTATION.
  METHOD if_ngc_clf_api_read~read.
    CLEAR: eo_clf_api_result, et_classification_object.
    et_classification_object = VALUE ngct_classification_object( (
                                       object_key       = lth_ngc_clf_val_value_used_lea=>gc_object_key_child
                                       technical_object = lth_ngc_clf_val_value_used_lea=>gc_technical_object_child
                                       change_number    = ''
                                       key_date         = sy-datum
                                       classification   = NEW ltd_ngc_clf(
                                                                iv_is_node                  = abap_false
                                                                is_classification_key       = VALUE #( object_key       = lth_ngc_clf_val_value_used_lea=>gc_object_key_child
                                                                                                       technical_object = lth_ngc_clf_val_value_used_lea=>gc_technical_object_child
                                                                                                       change_number    = space
                                                                                                       key_date         = sy-datum )
                                                                it_valuation_data_upd       = VALUE #( ( classtype       = lth_ngc_clf_val_value_used_lea=>gc_classtype
                                                                                                         object_state    = if_ngc_c=>gc_object_state-created
                                                                                                         charcinternalid = 2
                                                                                                         charcvalue      = lth_ngc_clf_val_value_used_lea=>gc_charcvalue_child ) )
                                                                it_child_classification_key = VALUE #( )
                                                                it_characteristic           = VALUE #( ( classtype             = lth_ngc_clf_val_value_used_lea=>gc_classtype
                                                                                                         charcinternalid       = 2
                                                                                                         key_date              = sy-datum
                                                                                                         characteristic_object = NEW ltd_ngc_characteristic( )
                                                                                                        ) )
                                                              )
                                     ) ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_api_factory DEFINITION FOR TESTING INHERITING FROM cl_ngc_api_factory.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_testdouble_instance
        RETURNING VALUE(ro_testdouble_instance) TYPE REF TO cl_ngc_api_factory.
    METHODS: get_api REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_ngc_api_factory IMPLEMENTATION.
  METHOD get_testdouble_instance.
    ro_testdouble_instance = NEW ltd_ngc_api_factory( ).
  ENDMETHOD.
  METHOD get_api.
    ro_api = NEW ltd_ngc_api( ).
  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_clf_val_value_used_lea DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_value_used_leaf DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_value_used_lea.

CLASS ltc_ngc_clf_val_value_used_lea DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_val_value_used_leaf.  "class under test
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: not_node FOR TESTING.
    METHODS: value_not_used FOR TESTING.
    METHODS: value_used FOR TESTING.
    METHODS: assert_error_message
      IMPORTING
        it_messages TYPE ngct_classification_msg.
ENDCLASS.


CLASS ltc_ngc_clf_val_value_used_lea IMPLEMENTATION.

  METHOD class_setup.


  ENDMETHOD.


  METHOD class_teardown.


  ENDMETHOD.


  METHOD setup.

  ENDMETHOD.


  METHOD teardown.


  ENDMETHOD.


  METHOD not_node.

    mo_cut = NEW cl_ngc_clf_val_value_used_leaf( ).
    mo_cut->mo_ngc_api_factory = ltd_ngc_api_factory=>get_testdouble_instance( ).

    DATA(lo_classification) = NEW ltd_ngc_clf(
                                iv_is_node                  = abap_false
                                is_classification_key       = VALUE #( )
                                it_valuation_data_upd       = VALUE #( )
                                it_child_classification_key = VALUE #( )
                                it_characteristic           = VALUE #( )
                              ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate(
      iv_classtype      = lth_ngc_clf_val_value_used_lea=>gc_classtype
      io_data_provider  = lo_classification
      io_classification = lo_classification
    ).

    cl_abap_unit_assert=>assert_bound(
      act = lo_clf_api_result
      msg = 'RO_CLF_API_RESULT is not bound!'
    ).

    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'RO_CLF_API_RESULT contains message(s)!'
    ).

  ENDMETHOD.

  METHOD value_not_used.

    mo_cut = NEW cl_ngc_clf_val_value_used_leaf( ).
    mo_cut->mo_ngc_api_factory = ltd_ngc_api_factory=>get_testdouble_instance( ).

    DATA(lo_classification) = NEW ltd_ngc_clf(
                                iv_is_node                  = abap_true
                                is_classification_key       = VALUE #( object_key       = lth_ngc_clf_val_value_used_lea=>gc_object_key_parent
                                                                       technical_object = lth_ngc_clf_val_value_used_lea=>gc_technical_object_parent
                                                                       change_number    = space
                                                                       key_date         = sy-datum )
                                it_valuation_data_upd       = VALUE #( ( classtype    = lth_ngc_clf_val_value_used_lea=>gc_classtype
                                                                         object_state = if_ngc_c=>gc_object_state-deleted
                                                                          " in CHARCVALUE there is the value which we remove
                                                                         charcvalue   = lth_ngc_clf_val_value_used_lea=>gc_charcvalue_parent ) )
                                it_child_classification_key = VALUE #( ( object_key       = lth_ngc_clf_val_value_used_lea=>gc_object_key_child
                                                                         technical_object = lth_ngc_clf_val_value_used_lea=>gc_technical_object_child
                                                                         change_number    = space
                                                                         key_date         = sy-datum ) )
                                it_characteristic           = VALUE #( )
                              ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate(
      iv_classtype      = lth_ngc_clf_val_value_used_lea=>gc_classtype
      io_data_provider  = lo_classification
      io_classification = lo_classification
    ).

    cl_abap_unit_assert=>assert_bound(
      act = lo_clf_api_result
      msg = 'RO_CLF_API_RESULT is not bound!'
    ).

    cl_abap_unit_assert=>assert_false(
      act = lo_clf_api_result->has_message( )
      msg = 'RO_CLF_API_RESULT contains message(s)!'
    ).


  ENDMETHOD.

  METHOD value_used.

    mo_cut = NEW cl_ngc_clf_val_value_used_leaf( ).
    mo_cut->mo_ngc_api_factory = ltd_ngc_api_factory=>get_testdouble_instance( ).

    DATA(lo_classification) = NEW ltd_ngc_clf(
                                iv_is_node                  = abap_true
                                is_classification_key       = VALUE #( object_key       = lth_ngc_clf_val_value_used_lea=>gc_object_key_parent
                                                                       technical_object = lth_ngc_clf_val_value_used_lea=>gc_technical_object_parent
                                                                       change_number    = space
                                                                       key_date         = sy-datum )
                                it_valuation_data_upd       = VALUE #( ( classtype    = lth_ngc_clf_val_value_used_lea=>gc_classtype
                                                                         object_state = if_ngc_c=>gc_object_state-deleted
                                                                          " in CHARCVALUE there is the value which we remove
                                                                         charcvalue   = lth_ngc_clf_val_value_used_lea=>gc_charcvalue_child ) )
                                it_child_classification_key = VALUE #( ( object_key       = lth_ngc_clf_val_value_used_lea=>gc_object_key_child
                                                                         technical_object = lth_ngc_clf_val_value_used_lea=>gc_technical_object_child
                                                                         change_number    = space
                                                                         key_date         = sy-datum ) )
                                it_characteristic           = VALUE #( )
                              ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate(
      iv_classtype      = lth_ngc_clf_val_value_used_lea=>gc_classtype
      io_data_provider  = lo_classification
      io_classification = lo_classification
    ).

    cl_abap_unit_assert=>assert_bound(
      act = lo_clf_api_result
      msg = 'RO_CLF_API_RESULT is not bound!'
    ).

    cl_abap_unit_assert=>assert_true(
      act = lo_clf_api_result->has_message( )
      msg = 'RO_CLF_API_RESULT does not contain message(s)!'
    ).

    assert_error_message( lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD assert_error_message.
    MESSAGE e025(ngc_api_base) WITH lth_ngc_clf_val_value_used_lea=>gc_description lth_ngc_clf_val_value_used_lea=>gc_charcvalue_child INTO DATA(lv_msg) ##NEEDED.
    READ TABLE it_messages TRANSPORTING NO FIELDS WITH KEY object_key       = lth_ngc_clf_val_value_used_lea=>gc_object_key_parent
                                                           technical_object = lth_ngc_clf_val_value_used_lea=>gc_technical_object_parent
                                                           change_number    = space
                                                           key_date         = sy-datum
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