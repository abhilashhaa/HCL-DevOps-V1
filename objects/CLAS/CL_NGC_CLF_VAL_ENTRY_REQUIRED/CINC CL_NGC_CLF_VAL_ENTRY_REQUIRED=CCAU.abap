*"* use this source file for your ABAP unit test classes

CLASS ltd_ngc_chr DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_ngc_characteristic.
    METHODS constructor
      IMPORTING
        is_characteristic_header TYPE ngcs_characteristic.
  PRIVATE SECTION.
    DATA: ms_characteristic_header               TYPE ngcs_characteristic.
ENDCLASS.

CLASS ltd_ngc_chr IMPLEMENTATION.
  METHOD constructor.
    me->ms_characteristic_header = is_characteristic_header.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_header.
    rs_characteristic_header = me->ms_characteristic_header.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_domain_values ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_characteristic_ref ##NEEDED.
  ENDMETHOD.

ENDCLASS.

CLASS ltd_ngc_cls DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_class.
    METHODS constructor
      IMPORTING
        is_header                TYPE ngcs_class
        it_class_characteristics TYPE ngct_class_characteristic OPTIONAL.
  PRIVATE SECTION.
    DATA: ms_header               TYPE ngcs_class,
          mt_class_characteristic TYPE ngct_characteristic_object.
ENDCLASS.

CLASS ltd_ngc_cls IMPLEMENTATION.
  METHOD constructor.
    ms_header = is_header.
    LOOP AT it_class_characteristics ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).
      APPEND VALUE #( charcinternalid = <ls_class_characteristic>-charcinternalid
                      key_date        = '20170130'
                      characteristic_object = NEW ltd_ngc_chr(
                        is_characteristic_header = VALUE #(
                          charcinternalid           = <ls_class_characteristic>-charcinternalid
                          characteristic            = <ls_class_characteristic>-characteristic
                          charcdatatype             = <ls_class_characteristic>-charcdatatype
                          charcdecimals             = <ls_class_characteristic>-charcdecimals
                          charcchecktable           = <ls_class_characteristic>-charcchecktable
                          multiplevaluesareallowed  = <ls_class_characteristic>-multiplevaluesareallowed
                          charclength               = <ls_class_characteristic>-charclength
                          charcvalueunit            = <ls_class_characteristic>-charcvalueunit
                          charcstatus               = <ls_class_characteristic>-charcstatus
                          charcreferencetable       = <ls_class_characteristic>-charcreferencetable
                          charcreferencetablefield  = <ls_class_characteristic>-charcreferencetablefield
                          entryisrequired           = <ls_class_characteristic>-entryisrequired
                          charcdescription          = <ls_class_characteristic>-charcdescription
                          ) ) )
*                        it_characteristic_value  = VALUE #( ) ) )
                  TO mt_class_characteristic.
    ENDLOOP.
  ENDMETHOD.
  METHOD if_ngc_class~get_header.
    rs_class_header = ms_header.
  ENDMETHOD.
  METHOD if_ngc_class~get_characteristics ##NEEDED.
    et_characteristic = mt_class_characteristic.
  ENDMETHOD.
ENDCLASS.


CLASS lth_ngc_clf_val_entry_required DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_one    TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_technical_object  TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date          TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_classtype         TYPE klassenart VALUE 'PB1'.
    CONSTANTS: gc_classinternalid       TYPE clint VALUE '0000006000'.
    CONSTANTS: gc_description TYPE atbez VALUE 'characteristic'.
ENDCLASS.

CLASS lth_ngc_clf_val_entry_required IMPLEMENTATION.
ENDCLASS.


CLASS ltd_ngc_clf_persistency DEFINITION FINAL INHERITING FROM cl_ngc_core_clf_persistency.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_testdouble_instance
        RETURNING VALUE(ro_testdouble_instance) TYPE REF TO cl_ngc_core_clf_persistency.
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

CLASS ltc_ngc_clf_val_entry_required DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_entry_required DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_entry_required.

CLASS ltc_ngc_clf_val_entry_required DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_val_entry_required.  "class under test
    CLASS-DATA gs_class_req TYPE ngcs_class.
    CLASS-DATA gt_charc_req TYPE ngct_class_characteristic.
    CLASS-DATA gt_charc TYPE ngct_class_characteristic.
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: entry_required FOR TESTING.
    METHODS: entry_not_required FOR TESTING.
    METHODS: assert_error_message
      IMPORTING
        it_messages TYPE ngct_classification_msg.
    METHODS: get_classification_stub
      IMPORTING
        iv_entry_required        TYPE boole_d DEFAULT abap_false
      RETURNING
        VALUE(ro_classification) TYPE REF TO if_ngc_classification.
ENDCLASS.


CLASS ltc_ngc_clf_val_entry_required IMPLEMENTATION.

  METHOD class_setup.


  ENDMETHOD.


  METHOD class_teardown.


  ENDMETHOD.


  METHOD setup.

    gs_class_req = VALUE #( classinternalid               = '0000006000' " with reference characteristic
                            classtype                     = 'PB1'
                            class                         = 'NEW_MAT_REF'
                            classstatus                   = '1'
                            classsearchauthgrp            = ''
                            classclassfctnauthgrp         = ''
                            classmaintauthgrp             = ''
                            documentinforecorddocnumber   = ''
                            documentinforecorddoctype     = ''
                            documentinforecorddocpart     = ''
                            documentinforecorddocversion  = ''
                            sameclassfctnreaction         =  'X'
                            clfnorganizationalarea        = ''
                            classstandardorgname          = ''
                            classstandardnumber           = ''
                            classstandardstartdate        = '00000000'
                            classstandardversionstartdate = '00000000'
                            classstandardversion          = '00'
                            classstandardcharctable       = ''
                            classislocal                  = ''
                            validitystartdate             = '20170111'
                            validityenddate               = '99991231'
*                            keydate                       = '20170210'
                            classtext                     = ''
                            classdescription              = 'new computer' ) ##NO_TEXT.

    gt_charc_req = VALUE #( ( charcinternalid           = '0000000104'
                              key_date                  = '20170130'
                              charcdatatype             = 'CHAR'
                              charclength               = 40
                              entryisrequired           = abap_true
                              charcdescription          = lth_ngc_clf_val_entry_required=>gc_description
     ) ) .

    gt_charc = VALUE #( ( charcinternalid           = '0000000104'
                          key_date                  = '20170130'
                          charcdatatype             = 'CHAR'
                          charclength               = 40
                          entryisrequired           = abap_false
                          charcdescription          = lth_ngc_clf_val_entry_required=>gc_description
     ) ) .

  ENDMETHOD.


  METHOD teardown.


  ENDMETHOD.


  METHOD entry_required.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate(
      iv_classtype      = lth_ngc_clf_val_entry_required=>gc_classtype
      io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
      io_classification = get_classification_stub( iv_entry_required = abap_true ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'API results not bound' ).

    assert_error_message( lo_clf_api_result->get_messages( ) ).

  ENDMETHOD.


  METHOD entry_not_required.

    mo_cut = NEW #( ).

    mo_cut->mo_clf_persistency = ltd_ngc_clf_persistency=>get_testdouble_instance( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Validator instance not bound' ).

    DATA(lo_clf_api_result) = mo_cut->if_ngc_clf_validator~validate(
      iv_classtype      = lth_ngc_clf_val_entry_required=>gc_classtype
      io_data_provider  = NEW ltd_ngc_clf_validation_dp( )
      io_classification = get_classification_stub( iv_entry_required = abap_false ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                        msg = 'API results not bound' ).
    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( )
                                         msg = 'Unexpected messages were returned' ).

  ENDMETHOD.

  METHOD get_classification_stub.

    ro_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    IF iv_entry_required = abap_true.
      cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
        )->set_parameter(
          name  = 'et_classification_data_upd'
          value = VALUE ngct_classification_data_upd( ( classinternalid = lth_ngc_clf_val_entry_required=>gc_classinternalid ) )
        )->set_parameter(
          name  = 'et_assigned_class_upd'
          value = VALUE ngct_class_object_upd( (
                                              classinternalid = lth_ngc_clf_val_entry_required=>gc_classinternalid
                                              key_date        = lth_ngc_clf_val_entry_required=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( is_header = gs_class_req
                                                                                 it_class_characteristics = gt_charc_req )
                                              object_state    = if_ngc_c=>gc_object_state-created ) )
        ).
      ro_classification->get_updated_data( ).
    ELSE.
      cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters(
        )->set_parameter(
          name  = 'et_classification_data_upd'
          value = VALUE ngct_classification_data_upd( ( classinternalid = lth_ngc_clf_val_entry_required=>gc_classinternalid ) )
        )->set_parameter(
          name  = 'et_assigned_class_upd'
          value = VALUE ngct_class_object_upd( (
                                              classinternalid = lth_ngc_clf_val_entry_required=>gc_classinternalid
                                              key_date        = lth_ngc_clf_val_entry_required=>gc_key_date
                                              class_object    = NEW ltd_ngc_cls( is_header = gs_class_req
                                                                                 it_class_characteristics = gt_charc )
                                              object_state    = if_ngc_c=>gc_object_state-created ) )
        ).
      ro_classification->get_updated_data( ).
    ENDIF.

    cl_abap_testdouble=>configure_call( ro_classification )->ignore_all_parameters( )->returning(
      VALUE ngcs_classification_key(
        object_key       = lth_ngc_clf_val_entry_required=>gc_object_key_one
        technical_object = lth_ngc_clf_val_entry_required=>gc_technical_object
        key_date         = lth_ngc_clf_val_entry_required=>gc_key_date
        change_number    = space ) ).
    ro_classification->get_classification_key( ).

  ENDMETHOD.

  METHOD assert_error_message.
    MESSAGE w015(ngc_api_base) WITH lth_ngc_clf_val_entry_required=>gc_description INTO DATA(lv_msg) ##NEEDED.
    READ TABLE it_messages TRANSPORTING NO FIELDS WITH KEY object_key       = lth_ngc_clf_val_entry_required=>gc_object_key_one
                                                           technical_object = lth_ngc_clf_val_entry_required=>gc_technical_object
                                                           key_date         = lth_ngc_clf_val_entry_required=>gc_key_date
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