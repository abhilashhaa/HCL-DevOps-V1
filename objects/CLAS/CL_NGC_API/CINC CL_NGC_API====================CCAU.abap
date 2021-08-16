CLASS lth_ngc_api DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_object_key_one TYPE cuobn VALUE '0000000001'.
    CONSTANTS: gc_object_key_two TYPE cuobn VALUE '0000000002'.
    CONSTANTS: gc_technical_object TYPE tabelle VALUE 'MARA'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CONSTANTS: gc_classtype TYPE klassenart VALUE '001'.
    CONSTANTS: gc_another_classtype TYPE klassenart VALUE '002'.
    CONSTANTS: gc_classinternalid TYPE clint VALUE '1'.
    CONSTANTS: gc_class TYPE klasse_d VALUE 'CLASS'.
    CONSTANTS: gc_classclassfctnauthgrp_auth TYPE bgrkl VALUE 'YES'.
    CONSTANTS: gc_classclassfctnauthgrp_fail TYPE bgrkl VALUE 'NO'.
    CONSTANTS: gc_classclassfctnauthgrp_init TYPE bgrkl VALUE IS INITIAL.
    CLASS-DATA: gt_classes TYPE ngct_core_class.
    CLASS-DATA: gt_classification TYPE ngct_core_classification.
    CLASS-DATA: gt_classification_data_upd TYPE ngct_classification_data_upd.
    CLASS-DATA: gt_class_object_upd TYPE ngct_class_object_upd.
    CLASS-DATA: gt_classification_data TYPE ngct_core_classification_data.
    CLASS-DATA: gt_valuation_data TYPE ngct_valuation_data.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_ngc_api IMPLEMENTATION.

  METHOD class_constructor.

    gt_classes = VALUE #( ( classinternalid               = '0000004610'
                            key_date                      = lth_ngc_api=>gc_key_date
                            classtype                     = '300'
                            class                         = 'CLASS_COMPUTER'
                            classstatus                   = '1'
                            classsearchauthgrp            = ''
                            classclassfctnauthgrp         = ''
                            classmaintauthgrp             = ''
                            documentinforecorddocnumber   = ''
                            documentinforecorddoctype     = ''
                            documentinforecorddocpart     = ''
                            documentinforecorddocversion  = ''
                            sameclassfctnreaction         = 'X'
                            clfnorganizationalarea        = 'J'
                            classstandardorgname          = ''
                            classstandardnumber           = ''
                            classstandardstartdate        = '00000000'
                            classstandardversionstartdate = '00000000'
                            classstandardversion          = '00'
                            classstandardcharctable       = ''
                            classislocal                  = ''
                            validitystartdate             = '20161124'
                            validityenddate               = '99991231'
*                            keydate                       = '20170120'
                            classtext                     = 'Computer Class (Standard Title)'
                            classdescription              = 'CLASS COMPUTER'
                            classstatusname               = 'Released'
                            classificationisallowed       = 'X' )

                          ( classinternalid               = '0000005905'
                            key_date                      = lth_ngc_api=>gc_key_date
                            classtype                     = '001'
                            class                         = 'HARRI_COMPUTER'
                            classstatus                   = '1'
                            classsearchauthgrp            = ''
                            classclassfctnauthgrp         = ''
                            classmaintauthgrp             = ''
                            documentinforecorddocnumber   = ''
                            documentinforecorddoctype     = ''
                            documentinforecorddocpart     = ''
                            documentinforecorddocversion  = ''
                            sameclassfctnreaction         = 'X'
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
*                            keydate                       = '20170120'
                            classtext                     = ''
                            classdescription              = 'computer'
                            classstatusname               = 'Released'
                            classificationisallowed       = 'X' )

                          ( classinternalid               = '0000005906'
                            key_date                      = lth_ngc_api=>gc_key_date
                            classtype                     = '200'
                            class                         = 'HARRI_ELECTRICITY'
                            classstatus                   = '1'
                            classsearchauthgrp            = ''
                            classclassfctnauthgrp         = ''
                            classmaintauthgrp             = ''
                            documentinforecorddocnumber   = ''
                            documentinforecorddoctype     = ''
                            documentinforecorddocpart     = ''
                            documentinforecorddocversion  = ''
                            sameclassfctnreaction         = 'X'
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
*                            keydate                       = '20170120'
                            classtext                     = ''
                            classdescription              = 'computer'
                            classstatusname               = 'Released'
                            classificationisallowed       = 'X' ) ).

    gt_classification_data = VALUE #( ( classinternalid       = gt_classes[ 1 ]-classinternalid
                                        class                 = gt_classes[ 1 ]-class
                                        classtype             = gt_classes[ 1 ]-classtype
                                        clfnstatus            = '1'
                                        clfnstatusdescription = 'Released'
                                        classpositionnumber   = '10'
                                        classisstandardclass  = abap_false
                                        changenumber          = '' )

                                      ( classinternalid       = gt_classes[ 2 ]-classinternalid
                                        class                 = gt_classes[ 2 ]-class
                                        classtype             = gt_classes[ 2 ]-classtype
                                        clfnstatus            = '1'
                                        clfnstatusdescription = 'Released'
                                        classpositionnumber   = '10'
                                        classisstandardclass  = abap_false
                                        changenumber          = '' )

                                      ( classinternalid       = gt_classes[ 3 ]-classinternalid
                                        class                 = gt_classes[ 3 ]-class
                                        classtype             = gt_classes[ 3 ]-classtype
                                        clfnstatus            = '1'
                                        clfnstatusdescription = 'Released'
                                        classpositionnumber   = '10'
                                        classisstandardclass  = abap_false
                                        changenumber          = '' ) ).

    gt_valuation_data = VALUE #(
      ( clfnobjectid             = lth_ngc_api=>gc_object_key_one
        charcinternalid          = '0000000001'
        charcvaluepositionnumber = '001'
        clfnobjecttype           = 'O'
        classtype                = '001'
        timeintervalnumber       = '0001'
        validitystartdate        = lth_ngc_api=>gc_key_date
        validityenddate          = '99991231' )
      ( clfnobjectid             = lth_ngc_api=>gc_object_key_one
        charcinternalid          = '0000000002'
        charcvaluepositionnumber = '001'
        clfnobjecttype           = 'O'
        classtype                = '001'
        timeintervalnumber       = '0001'
        validitystartdate        = lth_ngc_api=>gc_key_date
        validityenddate          = '99991231' ) ).

    gt_classification = VALUE #( ( object_key          = lth_ngc_api=>gc_object_key_one
                                   technical_object    = lth_ngc_api=>gc_technical_object
                                   change_number       = space
                                   key_date            = lth_ngc_api=>gc_key_date
                                   classification_data = gt_classification_data
                                   valuation_data      = gt_valuation_data )

                                 ( object_key          = lth_ngc_api=>gc_object_key_two
                                   technical_object    = lth_ngc_api=>gc_technical_object
                                   change_number       = space
                                   key_date            = lth_ngc_api=>gc_key_date
                                   classification_data = VALUE #( )
                                   valuation_data      = VALUE #( ) ) ).

    gt_classification_data_upd = VALUE #( ( classinternalid       = gt_classification_data[ 1 ]-classinternalid
                                            class                 = gt_classification_data[ 1 ]-class
                                            classtype             = gt_classification_data[ 1 ]-classtype
                                            clfnstatus            = gt_classification_data[ 1 ]-clfnstatus
                                            clfnstatusdescription = gt_classification_data[ 1 ]-clfnstatusdescription
                                            classpositionnumber   = gt_classification_data[ 1 ]-classpositionnumber
                                            classisstandardclass  = gt_classification_data[ 1 ]-classisstandardclass
                                            changenumber          = gt_classification_data[ 1 ]-changenumber
                                            lastchangedatetime    = gt_classification_data[ 1 ]-lastchangedatetime
                                            object_state          = if_ngc_c=>gc_object_state-loaded )
                                          ( classinternalid       = gt_classification_data[ 2 ]-classinternalid
                                            class                 = gt_classification_data[ 2 ]-class
                                            classtype             = gt_classification_data[ 2 ]-classtype
                                            clfnstatus            = gt_classification_data[ 2 ]-clfnstatus
                                            clfnstatusdescription = gt_classification_data[ 2 ]-clfnstatusdescription
                                            classpositionnumber   = gt_classification_data[ 2 ]-classpositionnumber
                                            classisstandardclass  = gt_classification_data[ 2 ]-classisstandardclass
                                            changenumber          = gt_classification_data[ 2 ]-changenumber
                                            lastchangedatetime    = gt_classification_data[ 2 ]-lastchangedatetime
                                            object_state          = if_ngc_c=>gc_object_state-loaded )
                                          ( classinternalid       = gt_classification_data[ 3 ]-classinternalid
                                            class                 = gt_classification_data[ 3 ]-class
                                            classtype             = gt_classification_data[ 3 ]-classtype
                                            clfnstatus            = gt_classification_data[ 3 ]-clfnstatus
                                            clfnstatusdescription = gt_classification_data[ 3 ]-clfnstatusdescription
                                            classpositionnumber   = gt_classification_data[ 3 ]-classpositionnumber
                                            classisstandardclass  = gt_classification_data[ 3 ]-classisstandardclass
                                            changenumber          = gt_classification_data[ 3 ]-changenumber
                                            lastchangedatetime    = gt_classification_data[ 3 ]-lastchangedatetime
                                            object_state          = if_ngc_c=>gc_object_state-loaded ) ).

  ENDMETHOD.

ENDCLASS.


CLASS ltd_ngc_clf DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_classification PARTIALLY IMPLEMENTED.
    METHODS constructor
      IMPORTING
        is_classification_key  TYPE ngcs_classification_key
        it_classification_data TYPE ngct_classification_data OPTIONAL
        it_assigned_classes    TYPE ngct_class_object OPTIONAL
        it_valuation_data      TYPE ngct_valuation_data OPTIONAL.
  PRIVATE SECTION.
    DATA ms_classification_key      TYPE ngcs_classification_key .
    DATA mt_classification_data_upd TYPE ngct_classification_data_upd .
    DATA mt_assigned_classes_upd    TYPE ngct_class_object_upd .
    DATA mt_valuation_data          TYPE ngct_valuation_data .
ENDCLASS.

CLASS ltd_ngc_clf IMPLEMENTATION.
  METHOD constructor.
    ms_classification_key     = is_classification_key.
    LOOP AT it_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data>).
      APPEND INITIAL LINE TO mt_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>).
      MOVE-CORRESPONDING <ls_classification_data> TO <ls_classification_data_upd>.
      <ls_classification_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
    ENDLOOP.
    LOOP AT it_assigned_classes ASSIGNING FIELD-SYMBOL(<ls_assigned_classes>).
      APPEND INITIAL LINE TO mt_assigned_classes_upd ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>).
      MOVE-CORRESPONDING <ls_assigned_classes> TO <ls_assigned_classes_upd>.
      <ls_assigned_classes_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
    ENDLOOP.

    mt_valuation_data = it_valuation_data.
  ENDMETHOD.
  METHOD if_ngc_classification~get_updated_data.
    et_classification_data_upd = mt_classification_data_upd.
    et_assigned_class_upd      = mt_assigned_classes_upd.
  ENDMETHOD.
  METHOD if_ngc_classification~assign_classes.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~get_assigned_classes.
  ENDMETHOD.
  METHOD if_ngc_classification~get_assigned_values.
    et_valuation_data = mt_valuation_data.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~get_classification_key.
    rs_classification_key = ms_classification_key.
  ENDMETHOD.
  METHOD if_ngc_classification~modify_classification_data.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~remove_classes.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~validate.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~get_domain_values.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~get_characteristics.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~change_status.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~get_classtypes.
  ENDMETHOD.
  METHOD if_ngc_classification~refresh_clf_status.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~change_values.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_classification~set_reference_data.
  ENDMETHOD.
  METHOD if_ngc_classification~get_reference_data.
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_cls DEFINITION.
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

CLASS ltd_ngc_api_factory DEFINITION FOR TESTING INHERITING FROM cl_ngc_api_factory.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_testdouble_instance
        RETURNING VALUE(ro_testdouble_instance) TYPE REF TO cl_ngc_api_factory.
    METHODS: create_classification REDEFINITION.
    METHODS: create_class_with_charcs REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_ngc_api_factory IMPLEMENTATION.
  METHOD get_testdouble_instance.
    ro_testdouble_instance = NEW ltd_ngc_api_factory( ).
  ENDMETHOD.
  METHOD create_classification.
    ro_classification = NEW ltd_ngc_clf(
      is_classification_key  = is_classification_key
      it_classification_data = it_classification_data
      it_assigned_classes    = it_assigned_classes
      it_valuation_data      = it_valuation_data ).
  ENDMETHOD.
  METHOD create_class_with_charcs.
    ro_class = NEW ltd_ngc_cls( is_class_header ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_clf_validation_mgr DEFINITION INHERITING FROM cl_ngc_clf_validation_mgr.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_testdouble_instance
        RETURNING VALUE(ro_testdouble_instance) TYPE REF TO cl_ngc_clf_validation_mgr.
    METHODS: validate REDEFINITION.
    METHODS: get_val_classification_keys
      RETURNING VALUE(rt_val_classification_keys) TYPE ngct_classification_key.
  PRIVATE SECTION.
    DATA: mv_validate_was_called TYPE boole_d VALUE abap_false.
    DATA: mt_classification_key TYPE ngct_classification_key.
ENDCLASS.

CLASS ltd_ngc_clf_validation_mgr IMPLEMENTATION.
  METHOD get_testdouble_instance.
    ro_testdouble_instance = NEW ltd_ngc_clf_validation_mgr( ).
  ENDMETHOD.
  METHOD validate.
    APPEND io_classification->get_classification_key( ) TO mt_classification_key.
    mv_validate_was_called = abap_true.
  ENDMETHOD.
  METHOD get_val_classification_keys.
    rt_val_classification_keys = mt_classification_key.
  ENDMETHOD.
ENDCLASS.

*--------------------------------------------------------------------*

CLASS ltc_ngc_api DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut             TYPE REF TO cl_ngc_api,
      mo_clf_persistency TYPE REF TO if_ngc_core_clf_persistency,
      mo_validation_mgr  TYPE REF TO cl_ngc_clf_validation_mgr.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: clf_read_empty_key_ok FOR TESTING.
    METHODS: clf_read_ok FOR TESTING.
    METHODS: class_read_empty_key_ok FOR TESTING.
    METHODS: class_read_by_ext_empty_key_ok FOR TESTING.
    METHODS: class_read_by_ext_ok FOR TESTING.
    METHODS: save FOR TESTING.
    METHODS: validate FOR TESTING.
    METHODS: update_empty FOR TESTING.

ENDCLASS.


CLASS ltc_ngc_api IMPLEMENTATION.

  METHOD class_setup.

  ENDMETHOD.


  METHOD class_teardown.

  ENDMETHOD.

  METHOD setup.

    DATA:
      lo_chr_persistency TYPE REF TO if_ngc_core_chr_persistency,
      lo_cls_persistency TYPE REF TO if_ngc_core_cls_persistency.

    " Create CHR Persistency stub.
    lo_chr_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_chr_persistency' ).

    " Create CLS Persistency stub.
    lo_cls_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_persistency' ).

    cl_abap_testdouble=>configure_call( lo_cls_persistency )->ignore_all_parameters( )->set_parameter( name = 'et_classes' value = lth_ngc_api=>gt_classes ).
    lo_cls_persistency->read_by_internal_key( VALUE #( ) ).

    cl_abap_testdouble=>configure_call( lo_cls_persistency )->ignore_all_parameters( )->set_parameter( name = 'et_classes' value = lth_ngc_api=>gt_classes ).
    lo_cls_persistency->read_by_external_key( VALUE #( ) ).

    " Set up CLF Persistency stub.
    mo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_testdouble=>configure_call( mo_clf_persistency )->ignore_all_parameters( )->set_parameter(
      name = 'et_classification'
      value = lth_ngc_api=>gt_classification ).
    mo_clf_persistency->read(
      it_keys = VALUE #( ) ).

    " Save validation manager to member variable.
    mo_validation_mgr = ltd_ngc_clf_validation_mgr=>get_testdouble_instance( ).

    " Inject stubs.
    mo_cut = NEW cl_ngc_api(
      io_api_factory        = ltd_ngc_api_factory=>get_testdouble_instance( )
      io_chr_persistency    = lo_chr_persistency
      io_clf_persistency    = mo_clf_persistency
      io_cls_persistency    = lo_cls_persistency
      io_clf_validation_mgr = mo_validation_mgr ).

  ENDMETHOD.

  METHOD teardown.

  ENDMETHOD.


  METHOD clf_read_empty_key_ok.

    " Given the classification data setup.
    " When the data is read by providing empty key in the input key table.
    mo_cut->if_ngc_clf_api_read~read( EXPORTING it_classification_key    = VALUE #( )
                                      IMPORTING et_classification_object = DATA(lt_classification) ).

    " Then an empty classification data table should be returned.
    cl_abap_unit_assert=>assert_initial( act = lt_classification
                                         msg = 'Returned classification list is not empty' ).

  ENDMETHOD.


  METHOD clf_read_ok.

    " Given the classification data setup.
    " When the classification and valuation data is read by providing a proper input key in the input key table.
    mo_cut->if_ngc_clf_api_read~read( EXPORTING it_classification_key    = VALUE #( ( object_key       = lth_ngc_api=>gc_object_key_one
                                                                                      technical_object = lth_ngc_api=>gc_technical_object
                                                                                      key_date         = lth_ngc_api=>gc_key_date
                                                                                      change_number    = space ) )
                                      IMPORTING et_classification_object = DATA(lt_classification) ).

    READ TABLE lt_classification INDEX 1 INTO DATA(ls_classification).

    ls_classification-classification->get_assigned_values(
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data) ).

    ls_classification-classification->get_updated_data(
      IMPORTING
        et_classification_data_upd = DATA(lt_classification_data_upd_act)
        et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).


    " Then the proper classification and valuation data should be returned.
    cl_abap_unit_assert=>assert_not_initial( act = lt_classification
                                             msg = 'Returned classification list is empty' ).

    cl_abap_unit_assert=>assert_equals( act = lines( lt_classification )
                                        exp = 1
                                        msg = 'Returned classification list contains more than 1 entries' ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification[ 1 ]-object_key
                                        exp = lth_ngc_api=>gc_object_key_one
                                        msg = 'Returned object key is wrong' ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification[ 1 ]-technical_object
                                        exp = lth_ngc_api=>gc_technical_object
                                        msg = 'Returned technical object is wrong' ).

    cl_abap_unit_assert=>assert_initial( act = lt_classification[ 1 ]-change_number
                                         msg = 'Returned change number is not empty' ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification[ 1 ]-key_date
                                        exp = lth_ngc_api=>gc_key_date
                                        msg = 'Returned key date is empty' ).

    cl_abap_unit_assert=>assert_bound( act = lt_classification[ 1 ]-classification
                                       msg = 'Returned classification object is not bound' ).


    cl_abap_unit_assert=>assert_equals(
      act = lt_valuation_data
      exp = lth_ngc_api=>gt_valuation_data
      msg = 'Valuation is incorrect' ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_upd_act
                                        exp = lth_ngc_api=>gt_classification_data_upd
                                        msg = 'CLF READ returned with unexpected data' ).

    cl_abap_unit_assert=>assert_equals( act = lines( lt_assigned_classes_upd )
                                        exp = lines( lth_ngc_api=>gt_classes )
                                        msg = 'CLF READ returned with unexpected data' ).


    LOOP AT lt_assigned_classes_upd ASSIGNING FIELD-SYMBOL(<ls_assigned_class_upd>).

      cl_abap_unit_assert=>assert_not_initial( act = <ls_assigned_class_upd>-classinternalid
                                               msg = 'CLF READ returned with unexpected data' ).

      cl_abap_unit_assert=>assert_equals( act = <ls_assigned_class_upd>-key_date
                                          exp = lth_ngc_api=>gc_key_date
                                          msg = 'CLF READ returned with unexpected data' ).

      cl_abap_unit_assert=>assert_equals( act = <ls_assigned_class_upd>-object_state
                                          exp = if_ngc_c=>gc_object_state-loaded
                                          msg = 'CLF READ returned with unexpected data' ).

      cl_abap_unit_assert=>assert_bound( act = <ls_assigned_class_upd>-class_object
                                         msg = 'CLF READ returned with unexpected data' ).

    ENDLOOP.

  ENDMETHOD.


  METHOD class_read_empty_key_ok.

    " Given the class master data setup.
    " When the data is read by providing empty key in the input key table.
    mo_cut->if_ngc_cls_api_read~read( EXPORTING it_class_key      = VALUE #( )
                                      IMPORTING et_class          = DATA(lt_classes)
                                                eo_cls_api_result = DATA(lo_cls_api_result) ).

    " Then an empty class data table should be returned, and also no messages should be returned.
    cl_abap_unit_assert=>assert_initial( act = lt_classes
                                         msg = 'Returned class list is not empty' ).

    cl_abap_unit_assert=>assert_bound( act = lo_cls_api_result
                                       msg = 'CLS READ returned with unexpected result' ).

    cl_abap_unit_assert=>assert_false( act = lo_cls_api_result->has_message( )
                                       msg = 'Returned message container is not empty' ).

  ENDMETHOD.


  METHOD class_read_by_ext_empty_key_ok.

    " Given the class master data setup.
    " When the data is read by providing empty external key in the input key table.
    mo_cut->if_ngc_cls_api_read~read_by_ext_key( EXPORTING it_class_key      = VALUE #( )
                                                 IMPORTING et_class          = DATA(lt_classes)
                                                           eo_cls_api_result = DATA(lo_cls_api_result) ).

    " Then an empty class data table should be returned, and also no messages should be returned.
    cl_abap_unit_assert=>assert_initial( act = lt_classes
                                         msg = 'Returned class list is not empty' ).

    cl_abap_unit_assert=>assert_bound( act = lo_cls_api_result
                                       msg = 'CLS READ_BY_EXT_KEY returned with unexpected result' ).

    cl_abap_unit_assert=>assert_false( act = lo_cls_api_result->has_message( )
                                       msg = 'Returned message container is not empty' ).

  ENDMETHOD.


  METHOD class_read_by_ext_ok.

    " Given the class master data setup.
    " When the data is read by providing proper external key in the input key table.
    mo_cut->if_ngc_cls_api_read~read_by_ext_key(
      EXPORTING it_class_key      = VALUE #( ( classtype = lth_ngc_api=>gc_classtype
                                               class     = lth_ngc_api=>gc_class
                                               key_date  = lth_ngc_api=>gc_key_date ) )
      IMPORTING et_class          = DATA(lt_classes)
                eo_cls_api_result = DATA(lo_cls_api_result) ).

    " Then the proper class data table should be returned, and also no messages should be returned.
    cl_abap_unit_assert=>assert_equals( act = lines( lt_classes )
                                        exp = 3
                                        msg = 'CLS READ_BY_EXT_KEY returned with unexpected result' ).

    cl_abap_unit_assert=>assert_bound( act = lo_cls_api_result
                                       msg = 'CLS READ_BY_EXT_KEY returned with unexpected result' ).

    cl_abap_unit_assert=>assert_initial( act = lo_cls_api_result->get_messages( )
                                         msg = 'CLS READ_BY_EXT_KEY returned with unexpected result' ).
  ENDMETHOD.


  METHOD save.

    " Given the instance of the persistency class.
    cl_abap_testdouble=>configure_call( mo_clf_persistency )->and_expect( )->is_called_once( ).
    mo_clf_persistency->save( ).

    " When the if_ngc_clf_api_write~save() is called of the CL_NGC_API class.
    mo_cut->if_ngc_clf_api_write~save( ).

    " Then the the save() of the persistency class is only called once.
    cl_abap_testdouble=>verify_expectations( mo_clf_persistency ).

  ENDMETHOD.


  METHOD validate.

    DATA:
      lo_clf_validation_mgr  TYPE REF TO ltd_ngc_clf_validation_mgr,
      lt_classification_keys TYPE ngct_classification_key.

    " Given the classification data setup.
    lt_classification_keys = VALUE #( ( object_key = lth_ngc_api=>gc_object_key_one
                                        technical_object = lth_ngc_api=>gc_technical_object
                                        key_date         = lth_ngc_api=>gc_key_date
                                        change_number    = space )
                                      ( object_key       = lth_ngc_api=>gc_object_key_two
                                        technical_object = lth_ngc_api=>gc_technical_object
                                        key_date         = lth_ngc_api=>gc_key_date
                                        change_number    = space ) ).

    " When the classification data is read by providing a proper input key in the input key table,
    " and then the validate() method of the write CLF interface is called.
    mo_cut->if_ngc_clf_api_read~read( EXPORTING it_classification_key    = lt_classification_keys
                                      IMPORTING et_classification_object = DATA(lt_classification) ).

    mo_cut->if_ngc_clf_api_write~validate( lt_classification ).

    " Then the validation manager's get_val_classification_keys() method should return the proper
    " classification keys. (Remark: Only those entries are validated where there is a classification
    " object (instance of IF_NGC_CLASSIFICATION) for the classification key.)
    lo_clf_validation_mgr ?= mo_validation_mgr.
    cl_abap_unit_assert=>assert_equals( act = lo_clf_validation_mgr->get_val_classification_keys( )
                                        exp = lt_classification_keys
                                        msg = 'CLF VALIDATE returned with unexpected result' ).

  ENDMETHOD.


  METHOD update_empty.

    DATA:
      lt_classification_keys     TYPE ngct_classification_key,
      lt_core_classification_upd TYPE ngct_core_classification_upd.

    " Given the classification data setup.
    lt_classification_keys = VALUE #( ( object_key       = lth_ngc_api=>gc_object_key_one
                                        technical_object = lth_ngc_api=>gc_technical_object
                                        key_date         = lth_ngc_api=>gc_key_date
                                        change_number    = space ) ).

    lt_core_classification_upd = VALUE #( ( object_key          = lth_ngc_api=>gc_object_key_one
                                            technical_object    = lth_ngc_api=>gc_technical_object
                                            key_date            = lth_ngc_api=>gc_key_date
                                            change_number       = space
                                            classification_data = VALUE #( ) ) ).

    cl_abap_testdouble=>configure_call( mo_clf_persistency )->ignore_parameter( 'it_class' )->and_expect(  )->is_called_once( ).
    mo_clf_persistency->write(
      it_classification = lt_core_classification_upd
      it_class          = VALUE #( ) ).

    " When the classification data is read by providing a proper input key in the input key table,
    " and then the update() method of the write interface is called with the classification data.
    mo_cut->if_ngc_clf_api_read~read( EXPORTING it_classification_key    = lt_classification_keys
                                      IMPORTING et_classification_object = DATA(lt_classification) ).

    mo_cut->if_ngc_clf_api_write~update( EXPORTING it_classification_object = lt_classification
                                         IMPORTING eo_clf_api_result        = DATA(lo_clf_api_result) ).

    " Then the update() should not return any messages and the write() method of the CLF persistency
    " should be called only once.
    cl_abap_unit_assert=>assert_bound( act = lo_clf_api_result
                                       msg = 'CLF UPDATE returned with unexpected result' ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'CLF UPDATE returned with unexpected result' ).

    cl_abap_testdouble=>verify_expectations( mo_clf_persistency ).

  ENDMETHOD.

ENDCLASS.