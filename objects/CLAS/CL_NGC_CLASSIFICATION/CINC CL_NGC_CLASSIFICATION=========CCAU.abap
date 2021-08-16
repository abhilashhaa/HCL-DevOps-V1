

CLASS ltd_ngc_core_chr_check_num DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ngc_core_chr_value_check.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO if_ngc_core_chr_value_check .
  PRIVATE SECTION.
    CLASS-DATA: go_check TYPE REF TO if_ngc_core_chr_value_check .
ENDCLASS.

CLASS ltd_ngc_core_chr_check_num IMPLEMENTATION.
  METHOD get_instance.
    IF go_check IS NOT BOUND.
      go_check = NEW ltd_ngc_core_chr_check_num( ).
    ENDIF.
    ro_instance = go_check.
  ENDMETHOD.
  METHOD if_ngc_core_chr_value_check~check_value.
    CLEAR: et_message.
    cs_charc_value-charcvalue = '10 KG'.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_core_chr_check_curr DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ngc_core_chr_value_check.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO if_ngc_core_chr_value_check .
  PRIVATE SECTION.
    CLASS-DATA: go_check TYPE REF TO if_ngc_core_chr_value_check .
ENDCLASS.

CLASS ltd_ngc_core_chr_check_curr IMPLEMENTATION.
  METHOD get_instance.
    IF go_check IS NOT BOUND.
      go_check = NEW ltd_ngc_core_chr_check_curr( ).
    ENDIF.
    ro_instance = go_check.
  ENDMETHOD.
  METHOD if_ngc_core_chr_value_check~check_value.
    cs_charc_value-charcvalue = '10 EUR'.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_core_chr_check_date DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ngc_core_chr_value_check.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO if_ngc_core_chr_value_check .
  PRIVATE SECTION.
    CLASS-DATA: go_check TYPE REF TO if_ngc_core_chr_value_check .
ENDCLASS.

CLASS ltd_ngc_core_chr_check_date IMPLEMENTATION.
  METHOD get_instance.
    IF go_check IS NOT BOUND.
      go_check = NEW ltd_ngc_core_chr_check_date( ).
    ENDIF.
    ro_instance = go_check.
  ENDMETHOD.
  METHOD if_ngc_core_chr_value_check~check_value.
    cs_charc_value-charcvalue = '20180502'.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_core_chr_check_time DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ngc_core_chr_value_check.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO if_ngc_core_chr_value_check .
  PRIVATE SECTION.
    CLASS-DATA: go_check TYPE REF TO if_ngc_core_chr_value_check .
ENDCLASS.

CLASS ltd_ngc_core_chr_check_time IMPLEMENTATION.
  METHOD get_instance.
    IF go_check IS NOT BOUND.
      go_check = NEW ltd_ngc_core_chr_check_time( ).
    ENDIF.
    ro_instance = go_check.
  ENDMETHOD.
  METHOD if_ngc_core_chr_value_check~check_value.
    cs_charc_value-charcvalue = '123456'.
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_core_chr_check_char DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ngc_core_chr_value_check.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO if_ngc_core_chr_value_check .
  PRIVATE SECTION.
    CLASS-DATA: go_check TYPE REF TO if_ngc_core_chr_value_check .
ENDCLASS.

CLASS ltd_ngc_core_chr_check_char IMPLEMENTATION.
  METHOD get_instance.
    IF go_check IS NOT BOUND.
      go_check = NEW ltd_ngc_core_chr_check_char( ).
    ENDIF.
    ro_instance = go_check.
  ENDMETHOD.
  METHOD if_ngc_core_chr_value_check~check_value.
    cs_charc_value-charcvalue = 'VALUE01' ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_clf_validation_mgr DEFINITION INHERITING FROM cl_ngc_clf_validation_mgr.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_testdouble_instance
        RETURNING VALUE(ro_testdouble_instance) TYPE REF TO cl_ngc_clf_validation_mgr.
    METHODS: validate REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_ngc_clf_validation_mgr IMPLEMENTATION.
  METHOD get_testdouble_instance.
    ro_testdouble_instance = NEW ltd_ngc_clf_validation_mgr( ).
  ENDMETHOD.
  METHOD validate ##NEEDED.
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_chr DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_ngc_characteristic.
    METHODS constructor
      IMPORTING
        is_characteristic_header TYPE ngcs_characteristic
        it_characteristic_value  TYPE ngct_characteristic_value OPTIONAL.
  PRIVATE SECTION.
    DATA: ms_characteristic_header TYPE ngcs_characteristic,
          mt_domain_value          TYPE ngct_characteristic_value.
ENDCLASS.

CLASS ltd_ngc_chr IMPLEMENTATION.
  METHOD constructor.
    me->ms_characteristic_header = is_characteristic_header.
    me->mt_domain_value          = it_characteristic_value.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_header.
    rs_characteristic_header = me->ms_characteristic_header.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_domain_values.
    et_domain_value = mt_domain_value.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_characteristic_ref ##NEEDED .
  ENDMETHOD.

ENDCLASS.

CLASS ltd_ngc_cls DEFINITION.
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
                          )
                        it_characteristic_value  = VALUE #( ) ) ) TO mt_class_characteristic.
    ENDLOOP.
  ENDMETHOD.
  METHOD if_ngc_class~get_header.
    rs_class_header = ms_header.
  ENDMETHOD.
  METHOD if_ngc_class~get_characteristics.
    et_characteristic = mt_class_characteristic.
  ENDMETHOD.
ENDCLASS.


CLASS lth_ngc_clf_testdata DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA gs_classification_key TYPE ngcs_classification_key.
    CLASS-DATA gt_classification_data TYPE ngct_classification_data.
    CLASS-DATA gt_assigned_classes TYPE ngct_class_object.
    CLASS-DATA gs_new_class TYPE ngcs_class.
    CLASS-DATA gs_class_ref TYPE ngcs_class.
    CLASS-DATA gs_new_class_ref TYPE ngcs_class.
    CLASS-DATA gs_new_class_dep TYPE ngcs_class.
    CLASS-DATA gs_new_class_duplicate TYPE ngcs_class.
    CLASS-DATA gs_class_remove TYPE ngcs_class.
    CLASS-DATA gt_charc_ref TYPE ngct_class_characteristic.
    CLASS-DATA gt_new_charc_ref TYPE ngct_class_characteristic.
    CLASS-DATA gt_new_charc_dep TYPE ngct_class_characteristic.
    CLASS-DATA gt_new_charc_duplicate TYPE ngct_class_characteristic.
    CLASS-DATA gt_charc_remove TYPE ngct_class_characteristic.
    CLASS-DATA gt_valuation_data TYPE ngct_valuation_data.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_ngc_clf_testdata IMPLEMENTATION.

  METHOD class_constructor.

    gs_classification_key = VALUE #(
      object_key       = 'TEST_FOCUS_OBJECT'
      technical_object = 'TESTTAB'
      change_number    = ''
      key_date         = '20170111'
    ).

    gs_new_class_duplicate = VALUE #( classinternalid               = '0000005905'
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
*                                      keydate                       = '20170120'
                                      classtext                     = ''
                                      classdescription              = 'computer'
                                      classstatusname               = 'Released'
                                      classificationisallowed       = 'X'
    ) ##NO_TEXT.

    gt_new_charc_duplicate = VALUE #(
            ( charcinternalid           = '0000000001' charcdatatype = if_ngc_c=>gc_charcdatatype-char )
            ( charcinternalid           = '0000000002' charcdatatype = if_ngc_c=>gc_charcdatatype-char )
    ) .

    gs_class_remove = VALUE #( classinternalid               = '0000006002' " dependency: remove
                               classtype                     = 'PB1'
                               class                         = 'DEP_REMOVE_CL'
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
*                               keydate                       = '20170120'
                               classtext                     = ''
                               classdescription              = 'class to be removed'
                               classstatusname               = 'Released'
                               classificationisallowed       = 'X'
    ) ##NO_TEXT.

    gt_charc_remove = VALUE #(
            ( charcinternalid           = '0000000107'
              key_date                  = '20170130'
              charcdatatype             = 'CHAR'
              charclength               = 40
              multiplevaluesareallowed  = abap_true )
            ( charcinternalid           = '0000000108'
              key_date                  = '20170130'
              charcdatatype             = 'CHAR'
              charclength               = 40
              multiplevaluesareallowed  = abap_true )
    ) .

    gs_class_ref = VALUE #( classinternalid               = '0000005999'
                            classtype                     = 'PB1'
                            class                         = 'PB_CL_FOR_REF'
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
                            classificationisallowed       = 'X'
    ) ##NO_TEXT.

    gt_charc_ref = VALUE #(
            ( charcinternalid           = '0000000100'
              charcreferencetable       = 'MARA'
              charcreferencetablefield  = 'MATNR'
              multiplevaluesareallowed    = abap_true )
            ( charcinternalid           = '0000000101'
              charcreferencetable       = 'CABN'
              charcreferencetablefield  = 'ATNAM'
              multiplevaluesareallowed    = abap_true )
            ( charcinternalid           = '0000000102'
              multiplevaluesareallowed    = abap_true )
    ) .

    gs_new_class_ref = VALUE #( classinternalid           = '0000006000' " with reference characteristic
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

    gt_new_charc_ref = VALUE #(
            ( charcinternalid           = '0000000104'
              key_date                  = '20170130'
              charcdatatype             = 'CHAR'
              charclength               = 40
              charcreferencetable       = 'MARA'
              charcreferencetablefield  = 'MATNR'
              multiplevaluesareallowed  = abap_true )
            ( charcinternalid           = '0000000106'
              key_date                  = '20170130'
              charcdatatype             = 'CHAR'
              charclength               = 40
              multiplevaluesareallowed  = abap_true )
    ) .

    gt_assigned_classes = VALUE #(
      ( classinternalid = '0000004610'
        class_object    = NEW ltd_ngc_cls(
          is_header                = VALUE #( classinternalid               = '0000004610'
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
*                                              keydate                       = '20170120'
                                              classtext                     = 'Computer Class (Standard Title)'
                                              classdescription              = 'CLASS COMPUTER'
                                              classstatusname               = 'Released'
                                              classificationisallowed       = 'X' )
          it_class_characteristics = VALUE #(
            ( classinternalid = '0000004610' charcinternalid = '0000000001' charcdatatype = if_ngc_c=>gc_charcdatatype-char                       )
            ( classinternalid = '0000004610' charcinternalid = '0000000003' charcdatatype = if_ngc_c=>gc_charcdatatype-curr                       )
            ( classinternalid = '0000004610' charcinternalid = '0000000004' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charcvalueunit = 'KG' charclength = '10' charcdecimals = '3' )
            ( classinternalid = '0000004610' charcinternalid = '0000000005' charcdatatype = if_ngc_c=>gc_charcdatatype-date                       )
            ( classinternalid = '0000004610' charcinternalid = '0000000006' charcdatatype = if_ngc_c=>gc_charcdatatype-time                       )
            ( classinternalid = '0000004610' charcinternalid = '0000000010' charcdatatype = if_ngc_c=>gc_charcdatatype-curr                       )
            ( classinternalid = '0000004610' charcinternalid = '0000000011' charcdatatype = if_ngc_c=>gc_charcdatatype-num  charcvalueunit = 'KG' charclength = '10' charcdecimals = '3' )
            ( classinternalid = '0000004610' charcinternalid = '0000000012' charcdatatype = if_ngc_c=>gc_charcdatatype-date                       )
            ( classinternalid = '0000004610' charcinternalid = '0000000013' charcdatatype = if_ngc_c=>gc_charcdatatype-time                       )
            ( classinternalid = '0000004610' charcinternalid = '0000000014' charcdatatype = if_ngc_c=>gc_charcdatatype-char multiplevaluesareallowed = abap_true )
          )
        )
      )

      ( classinternalid = gs_new_class_duplicate-classinternalid "'0000005905'
        class_object    = NEW ltd_ngc_cls(
            is_header                = gs_new_class_duplicate
            it_class_characteristics = gt_new_charc_duplicate ) )

      ( classinternalid = '0000005906'
        class_object    = NEW ltd_ngc_cls(  VALUE #( classinternalid               = '0000005906'
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
*                                                     keydate                       = '20170120'
                                                     classtext                     = ''
                                                     classdescription              = 'computer'
                                                     classstatusname               = 'Released'
                                                     classificationisallowed       = 'X' ) ) )


       ( classinternalid = gs_class_ref-classinternalid " check reference characteristic
         class_object    = NEW ltd_ngc_cls(
           is_header                = gs_class_ref
           it_class_characteristics = gt_charc_ref )
       )
       ( classinternalid = gs_class_remove-classinternalid " check remove class process after valuation
         class_object    = NEW ltd_ngc_cls(
           is_header                = gs_class_remove
           it_class_characteristics = gt_charc_remove )
       )
    ) ##NO_TEXT.

    gs_new_class = VALUE #( classinternalid               = '0000009999'
                            classtype                     = '001'
                            class                         = 'NEW_COMPUTER'
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
                            classdescription              = 'new computer'
                            ) ##NO_TEXT.



    gs_new_class_dep = VALUE #( classinternalid               = '0000006001' " dependency: assign and remove
                                classtype                     = 'PB1'
                                class                         = 'DEP_NEW_CL'
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
*                                keydate                       = '20170210'
                                classtext                     = ''
                                classdescription              = 'new computer'
    ) ##NO_TEXT.

    gt_new_charc_dep = VALUE #(
            ( charcinternalid           = '0000000105' "new characteristic
              key_date                  = '20170130'
              charcdatatype             = 'CHAR'
              charclength               = 3
              multiplevaluesareallowed  = abap_true )
            ( charcinternalid           = '0000000001' "already used characteristic
              key_date                  = '20170130'
              charcdatatype             = 'CHAR'
              charclength               = 40
              multiplevaluesareallowed  = abap_true )
    ) .

    gt_valuation_data = VALUE ngct_valuation_data(
                 ( clfnobjectid    = 'TEST_FOCUS_OBJECT'
                   charcinternalid = '0000000001'
                   charcvalue      = 'VALUE01'
                   classtype       = '300' )
                 ( clfnobjectid    = 'TEST_FOCUS_OBJECT'
                   charcinternalid = '0000000001'
                   charcvalue      = 'VALUE02'
                   classtype       = '300' )
                 ( clfnobjectid    = 'TEST_FOCUS_OBJECT'
                   charcinternalid = '0000000002'
                   charcvalue      = 'VALUE03'
                   classtype       = '001' )
                 ( clfnobjectid    = 'TEST_FOCUS_OBJECT' " remove class
                   charcinternalid = '0000000107'
                   charcvalue      = 'ASSIGNED_VALUE'
                   classtype       = 'PB1' )
                 ( clfnobjectid    = 'PB_MAT_FOR_REF' " reference characteristic
                   charcinternalid = '0000000100'
                   charcvalue      = 'XYZ'
                   classtype       = 'PB1' )
                 ( clfnobjectid    = 'PB_MAT_FOR_REF' " reference characteristic
                   charcinternalid = '0000000101'
                   charcvalue      = 'ABC'
                   classtype       = 'PB1' )
                 ( clfnobjectid    = 'PB_MAT_FOR_REF' " reference characteristic
                   charcinternalid = '0000000101'
                   charcvalue      = 'DFG'
                   classtype       = 'PB1' )

                 ( clfnobjectid              = 'TEST_FOCUS_OBJECT'
                   charcinternalid           = '0000000010'
                   charcfromdecimalvalue     = 10
                   charcvalue                = '10 EUR'
                   charcfromamount           = '10'
                   currency                  = 'EUR'
                   charcvaluedependency      = '1'
                   classtype                 = '300' )
                 ( clfnobjectid              = 'TEST_FOCUS_OBJECT'
                   charcinternalid           = '0000000011'
                   charcfromdecimalvalue     = 10
                   charcvalue                = '10 KG'
                   charcfromnumericvalue     = 10
                   charcfromnumericvalueunit = 'KG'
                   charcvaluedependency      = '1'
                   classtype                 = '300' )
                 ( clfnobjectid              = 'TEST_FOCUS_OBJECT'
                   charcinternalid           = '0000000012'
                   charcfromdecimalvalue     = '20180502'
                   charcvalue                = '20180502'
                   charcfromdate             = '20180502'
                   charcvaluedependency      = '1'
                   classtype                 = '300' )
                 ( clfnobjectid              = 'TEST_FOCUS_OBJECT'
                   charcinternalid           = '0000000013'
                   charcvalue                = '12:34:56'
                   charcfromtime             = '123456'
                   charcvaluedependency      = '1'
                   classtype                 = '300' )

                 ( clfnobjectid              = 'TEST_FOCUS_OBJECT'
                   charcinternalid           = '0000000014'
                   charcvalue                = 'VALUE01'
                   charcvaluedependency      = '1'
                   classtype                 = '300' )
                 ( clfnobjectid              = 'TEST_FOCUS_OBJECT'
                   charcinternalid           = '0000000014'
                   charcvalue                = 'VALUE02'
                   charcvaluedependency      = '1'
                   classtype                 = '300' )
    ).

    gt_classification_data = VALUE #(

      ( classinternalid       = gs_new_class_duplicate-classinternalid  " '0000005905'
        class                 = gs_new_class_duplicate-class            " 'HARRI_COMPUTER'
        classtype             = gs_new_class_duplicate-classtype        " '001'
        clfnstatus            = '1'
        clfnstatusdescription = 'Released'
        classpositionnumber   = '10'
        classisstandardclass  = abap_false )
      ( classinternalid       = '0000005906'
        class                 = 'HARRI_ELECTRICITY'
        classtype             = '200'
        clfnstatus            = '1'
        clfnstatusdescription = 'Released'
        classpositionnumber   = '10'
        classisstandardclass  = abap_false )
      ( classinternalid       = '0000004610'
        class                 = 'CLASS_COMPUTER'
        classtype             = '300'
        clfnstatus            = '1'
        clfnstatusdescription = 'Released'
        classpositionnumber   = '10'
        classisstandardclass  = abap_false )
      ( classinternalid       = gs_class_remove-classinternalid   " '0000004610'
        class                 = gs_class_remove-class             " 'CLASS_COMPUTER'
        classtype             = gs_class_remove-classtype         " '300'
        clfnstatus            = '1'
        clfnstatusdescription = 'Released'
        classpositionnumber   = '10'
        classisstandardclass  = abap_false )
    ) ##NO_TEXT.

  ENDMETHOD.

ENDCLASS.


CLASS ltd_ngc_api DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_api PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_api IMPLEMENTATION.
  METHOD if_ngc_cls_api_read~read.
    IF ( it_class_key[ 1 ]-classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid ).
      et_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                            key_date        = '20170210'
                            class_object    = NEW ltd_ngc_cls( lth_ngc_clf_testdata=>gs_new_class ) ) ).
    ELSEIF ( it_class_key[ 1 ]-classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid ).
      et_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid
                            key_date        = '20170210'
                            class_object    = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object ) ).
    ENDIF.
    eo_cls_api_result = NEW cl_ngc_cls_api_result( ).
  ENDMETHOD.
  METHOD if_ngc_cls_api_read~read_by_ext_key.
    IF  ( it_class_key[ 1 ]-class     = lth_ngc_clf_testdata=>gs_new_class-class
      AND it_class_key[ 1 ]-classtype = lth_ngc_clf_testdata=>gs_new_class-classtype ).
      et_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                            key_date        = '20170210'
                            class_object    = NEW ltd_ngc_cls( lth_ngc_clf_testdata=>gs_new_class ) ) ).
    ELSE.
      IF ( it_class_key[ 1 ]-class     = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object->get_header( )-class
       AND it_class_key[ 1 ]-classtype = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object->get_header( )-classtype ).
        et_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid
                              key_date        = '20170210'
                              class_object    = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object ) ).
      ENDIF.
    ENDIF.
    eo_cls_api_result = NEW cl_ngc_cls_api_result( ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_api_factory DEFINITION FOR TESTING INHERITING FROM cl_ngc_api_factory.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_testdouble_instance
        RETURNING VALUE(ro_testdouble_instance) TYPE REF TO cl_ngc_api_factory.
    METHODS: create_classification REDEFINITION.
    METHODS: create_class_with_charcs REDEFINITION.
    METHODS: create_characteristic REDEFINITION.
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
  METHOD create_classification.
    ASSERT 1 = 2.
*    ro_classification = NEW ltd_ngc_clf(
*      is_classification_key  = is_classification_key
*      it_classification_data = it_classification_data
*      it_assigned_classes    = it_assigned_classes
*      it_valuation_data      = it_valuation_data ).
  ENDMETHOD.
  METHOD create_class_with_charcs.
    ro_class = NEW ltd_ngc_cls( is_class_header ).
  ENDMETHOD.
  METHOD create_characteristic.
    ro_characteristic = NEW ltd_ngc_chr(
        is_characteristic_header = is_characteristic_header
        it_characteristic_value  = it_characteristic_value ).
  ENDMETHOD.
ENDCLASS.


CLASS ltd_core_util DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_core_util.
ENDCLASS.

CLASS ltd_core_util IMPLEMENTATION.
  METHOD if_ngc_core_util~ctcv_syntax_check.
    APPEND VALUE #( atwrt = string atcod = 1 atinp = string ) TO tstrg.
  ENDMETHOD.
ENDCLASS.


*--------------------------------------------------------------------*

CLASS ltc_ngc_classification DEFINITION DEFERRED.
CLASS cl_ngc_classification DEFINITION LOCAL FRIENDS ltc_ngc_classification.

CLASS ltc_ngc_classification DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_classification.

    CLASS-DATA:
      mo_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_assigned_classes FOR TESTING.
    METHODS: get_classification_key FOR TESTING.
    METHODS: assign_new_class FOR TESTING.
    METHODS: assign_new_class_by_int_key FOR TESTING.
    METHODS: assign_new_class_by_ext_key FOR TESTING.
    METHODS: delete_class FOR TESTING.
    METHODS: delete_class_by_int_key FOR TESTING.
    METHODS: delete_class_by_ext_key FOR TESTING.
    METHODS: delete_then_assign_class FOR TESTING.
    METHODS: assign_then_delete_class FOR TESTING.
    METHODS: load_then_modify_clf_data FOR TESTING.
    METHODS: assign_then_modify_clf_data FOR TESTING.
    METHODS: set_get_updated_data FOR TESTING.
    METHODS: get_characteristics_by_cltype FOR TESTING.
    METHODS: get_characteristics_by_char FOR TESTING.
    METHODS: get_valuation_all FOR TESTING.
    METHODS: get_valuation_by_cltype FOR TESTING.
    METHODS: reference_characteristic FOR TESTING.
    METHODS: dependency_assign_remove_class FOR TESTING.
    METHODS: dependency_remove_class FOR TESTING.
    METHODS: assign_already_assigned_class FOR TESTING.
    METHODS: update_temporary_key FOR TESTING.
    METHODS: update_temporary_key_valuation FOR TESTING.
    METHODS: update_temporary_key_clfn FOR TESTING.
    METHODS: change_values FOR TESTING.
    METHODS: set_char_value FOR TESTING.
    METHODS: set_curr_value FOR TESTING.
    METHODS: set_num_value FOR TESTING.
    METHODS: set_date_value FOR TESTING.
    METHODS: set_time_value FOR TESTING.
    METHODS: delete_char_value FOR TESTING.
    METHODS: delete_curr_value FOR TESTING.
    METHODS: delete_num_value FOR TESTING.
    METHODS: delete_date_value FOR TESTING.
    METHODS: change_values_existing_value FOR TESTING.
    METHODS: assert_clf_instance_bound.
    METHODS: assert_clf_data_eq_testdata
      IMPORTING it_classification_data TYPE ngct_classification_data.
    METHODS: assert_assgnd_cls_eq_testdata
      IMPORTING it_assigned_classes TYPE ngct_class_object.
    METHODS: assert_assgnd_cls_cont_new_cls
      IMPORTING it_assigned_classes TYPE ngct_class_object.
    METHODS: assert_val_classtype_contains
      IMPORTING iv_classtype              TYPE klassenart
                it_validation_class_types TYPE ngct_class_types.
ENDCLASS.


CLASS ltc_ngc_classification IMPLEMENTATION.

  METHOD class_setup.

    DATA:
      lt_tcla  TYPE STANDARD TABLE OF tcla WITH EMPTY KEY,
      lt_tclao TYPE STANDARD TABLE OF tclao WITH EMPTY KEY,
      lo_tcla  TYPE REF TO if_cds_test_data,
      lo_tclao TYPE REF TO if_cds_test_data.

    mo_environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnClassType' ).
    mo_environment->clear_doubles( ).
    lt_tcla = VALUE #(
      ( mandt = sy-mandt obtab = 'MARA' klart = '001' intklart = ''  )
      ( mandt = sy-mandt obtab = 'EQUI' klart = '002' intklart = ''  )
      ( mandt = sy-mandt obtab = 'MCHA' klart = '022' intklart = 'X' )
      ( mandt = sy-mandt obtab = 'MCHA' klart = '023' intklart = ''  )
      ( mandt = sy-mandt obtab = 'MARA' klart = '026' intklart = 'X' )
      ( mandt = sy-mandt obtab = 'MARA' klart = '200' intklart = ''  )
      ( mandt = sy-mandt obtab = 'MARA' klart = '300' intklart = ''  )
      ( mandt = sy-mandt obtab = 'MARA' klart = 'PB1' intklart = '' multobj = 'X' )
    ).
    lo_tcla = cl_cds_test_data=>create( i_data = lt_tcla ).
    DATA(lo_tcla_stub) = mo_environment->get_double( i_name = 'TCLA' ).
    lo_tcla_stub->insert( lo_tcla ).

    lt_tclao = VALUE #(
      ( mandt = sy-mandt obtab = 'TESTTAB'  klart = 'PB1' zaehl = '01' )
      ( mandt = sy-mandt obtab = 'TESTTAB2' klart = 'PB1' zaehl = '03' )
    ).
    lo_tclao = cl_cds_test_data=>create( i_data = lt_tclao ).
    DATA(lo_tclao_stub) = mo_environment->get_double( i_name = 'TCLAO' ).
    lo_tclao_stub->insert( lo_tclao ).

  ENDMETHOD.


  METHOD class_teardown.

  ENDMETHOD.


  METHOD setup.

    DATA:
      lo_clf_persistency TYPE REF TO if_ngc_core_clf_persistency,
      lo_chr_persistency TYPE REF TO if_ngc_core_chr_persistency,
      lo_clf_status      TYPE REF TO if_ngc_clf_status.

    TEST-INJECTION badi_check_assign_classes.
    END-TEST-INJECTION.
    TEST-INJECTION badi_check_change_values.
    END-TEST-INJECTION.
    TEST-INJECTION badi_check_remove_classes.
    END-TEST-INJECTION.
    TEST-INJECTION badi_get_node_leaf.
    END-TEST-INJECTION.

*    th_ngc_core_factory_inj=>stub_all( ).

    " Set up CLF Persistency stub.
    lo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_abap_testdouble=>configure_call( lo_clf_persistency )->ignore_all_parameters( )->returning(
      VALUE ngct_core_classification_stat(
        ( klart      = '001'
          statu      = 1
          frei       = abap_true
          gesperrt   = abap_false
          unvollstm  = abap_false
          unvollsts  = abap_false
          loeschvorm = abap_false
          clautorel  = abap_false
          claedimand = abap_false ) ) ).
    lo_clf_persistency->read_clf_statuses( iv_classtype = '001' ).

    cl_abap_testdouble=>configure_call( lo_clf_persistency )->ignore_all_parameters( )->returning( 'Released' ).
    lo_clf_persistency->read_clf_status_description(
      iv_classtype  = '001'
      iv_clfnstatus = '' ).

    " Set up CLF status stub.
    lo_clf_status ?= cl_abap_testdouble=>create( 'if_ngc_clf_status' ).

    cl_abap_testdouble=>configure_call( lo_clf_status )->ignore_all_parameters( )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) ).
    lo_clf_status->refresh_status( mo_cut ).

    " Set up CLF status stub.

*    lo_clf_util_intersect ?= cl_abap_testdouble=>create('cl_ngc_clf_util_intersect' ).

    cl_abap_testdouble=>configure_call( lo_clf_status )->ignore_all_parameters( )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) ).
    lo_clf_status->change_status( io_classification = mo_cut iv_classinternalid = '0000000001' iv_status = '' ).

    cl_abap_testdouble=>configure_call( lo_clf_status )->ignore_all_parameters( )->set_parameter(
      name  = 'eo_clf_api_result'
      value = NEW cl_ngc_clf_api_result( ) ).
    lo_clf_status->refresh_status( mo_cut ).

    " CHR Persistency stub
    lo_chr_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_chr_persistency' ).

    " Inject stubs.
    mo_cut = NEW #( is_classification_key  = lth_ngc_clf_testdata=>gs_classification_key
                    it_classification_data = lth_ngc_clf_testdata=>gt_classification_data
                    it_assigned_classes    = lth_ngc_clf_testdata=>gt_assigned_classes
                    it_valuation_data      = lth_ngc_clf_testdata=>gt_valuation_data
                    io_ngc_api_factory     = ltd_ngc_api_factory=>get_testdouble_instance( ) ).

*    mo_cut->mo_clf_persistency        = ltd_ngc_clf_persistency=>get_testdouble_instance( ).
    mo_cut->mo_clf_persistency        = lo_clf_persistency.
    mo_cut->mo_chr_persistency        = lo_chr_persistency.
    mo_cut->mo_clf_validation_manager = ltd_ngc_clf_validation_mgr=>get_testdouble_instance( ).
    mo_cut->mo_clf_status             = lo_clf_status.
**    mo_cut->mo_clf_util_intersect     = lo_clf_util_intersect.

  ENDMETHOD.


  METHOD teardown.

  ENDMETHOD.

  METHOD change_values.

    mo_cut->if_ngc_classification~change_values(
      EXPORTING
        it_change_value   = VALUE #(
          ( classtype = '300' charcinternalid = '0000000014' charcvaluenew = '''VALUE;SEPARATED''' ) )
      IMPORTING
        et_change_value   = DATA(lt_change_value)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    cl_abap_unit_assert=>assert_not_initial( lt_change_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = lo_clf_api_result
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000014' charcvalue = '''VALUE;SEPARATED'''.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000014 should be assigned!' ).

  ENDMETHOD.

  METHOD set_char_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-char
      io_value_check     = ltd_ngc_core_chr_check_char=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000003'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000003 should not be assigned!' ).

    mo_cut->if_ngc_classification~set_character_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype            = '300'
                                       charcinternalid      = '0000000003'
                                       charcvalue           = 'VALUE01' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    READ TABLE lt_valuation_data INTO DATA(ls_valuation_data) WITH KEY charcinternalid = '0000000003' charcvalue = 'VALUE01'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000003 should be assigned!' ).
    cl_abap_unit_assert=>assert_equals(
      act = ls_valuation_data-clfnobjectid
      exp = lth_ngc_clf_testdata=>gs_classification_key-object_key ).

  ENDMETHOD.

  METHOD set_curr_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-curr
      io_value_check     = ltd_ngc_core_chr_check_curr=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000003'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000003 should not be assigned!' ).

    mo_cut->if_ngc_classification~set_currency_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype            = '300'
                                       charcinternalid      = '0000000003'
                                       charcvaluedependency = '1'
                                       charcfromamount      = '10'
                                       charctoamount        = '' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    READ TABLE lt_valuation_data INTO DATA(ls_valuation_data) WITH KEY charcinternalid = '0000000003' charcvalue = '10 EUR'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000003 should be assigned!' ).
    cl_abap_unit_assert=>assert_equals(
      act = ls_valuation_data-clfnobjectid
      exp = lth_ngc_clf_testdata=>gs_classification_key-object_key ).

  ENDMETHOD.


  METHOD set_num_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-num
      io_value_check     = ltd_ngc_core_chr_check_num=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000004'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000004 should not be assigned!' ).

    mo_cut->if_ngc_classification~set_numeric_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype                 = '300'
                                       charcinternalid           = '0000000004'
                                       charcvaluedependency      = '1'
                                       charcfromdecimalvalue     = '10'
                                       charctodecimalvalue       = ''
                                       charcfromnumericvalueunit = 'KG'
                                       charctonumericvalueunit   = '' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).
    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    READ TABLE lt_valuation_data INTO DATA(ls_valuation_data) WITH KEY charcinternalid = '0000000004' charcvalue = '10 KG'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000004 should be assigned!' ).
    cl_abap_unit_assert=>assert_equals(
      act = ls_valuation_data-clfnobjectid
      exp = lth_ngc_clf_testdata=>gs_classification_key-object_key ).

  ENDMETHOD.


  METHOD set_date_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-date
      io_value_check     = ltd_ngc_core_chr_check_date=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_initial( lo_clf_api_result->get_messages( ) ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000005'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000005 should not be assigned!' ).

    mo_cut->if_ngc_classification~set_date_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype            = '300'
                                       charcinternalid      = '0000000005'
                                       charcvaluedependency = '1'
                                       charcfromdate        = '20180502'
                                       charctodate          = '' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_initial( lo_clf_api_result->get_messages( ) ).
    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    cl_abap_unit_assert=>assert_initial( lo_clf_api_result->get_messages( ) ).

    READ TABLE lt_valuation_data INTO DATA(ls_valuation_data) WITH KEY charcinternalid = '0000000005' charcvalue = '20180502'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000005 should be assigned!' ).
    cl_abap_unit_assert=>assert_equals(
      act = ls_valuation_data-clfnobjectid
      exp = lth_ngc_clf_testdata=>gs_classification_key-object_key ).

  ENDMETHOD.


  METHOD set_time_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-time
      io_value_check     = ltd_ngc_core_chr_check_time=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_initial( lo_clf_api_result->get_messages( ) ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000006'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000006 should not be assigned!' ).

    mo_cut->if_ngc_classification~set_time_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype            = '300'
                                       charcinternalid      = '0000000006'
                                       charcvaluedependency = '1'
                                       charcfromtime        = '123456'
                                       charctotime          = '' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_initial( lo_clf_api_result->get_messages( ) ).
    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    cl_abap_unit_assert=>assert_initial( lo_clf_api_result->get_messages( ) ).

    READ TABLE lt_valuation_data INTO DATA(ls_valuation_data) WITH KEY charcinternalid = '0000000006' charcvalue = '123456'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000006 should be assigned!' ).
    cl_abap_unit_assert=>assert_equals(
      act = ls_valuation_data-clfnobjectid
      exp = lth_ngc_clf_testdata=>gs_classification_key-object_key ).

  ENDMETHOD.


  METHOD delete_char_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-char
      io_value_check     = ltd_ngc_core_chr_check_char=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000014'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000014 should be assigned!' ).


    mo_cut->if_ngc_classification~delete_character_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype            = '300'
                                       charcinternalid      = '0000000014'
                                       charcvalue           = 'VALUE01' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( ) ).
    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000014'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000014 should not be assigned!' ).


  ENDMETHOD.


  METHOD delete_curr_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-curr
      io_value_check     = ltd_ngc_core_chr_check_curr=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000010'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000010 should be assigned!' ).


    mo_cut->if_ngc_classification~delete_currency_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype            = '300'
                                       charcinternalid      = '0000000010'
                                       charcvaluedependency = '1'
                                       charcfromamount      = '10'
                                       charctoamount        = '' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( ) ).
    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000010'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000010 should not be assigned!' ).


  ENDMETHOD.


  METHOD delete_num_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-num
      io_value_check     = ltd_ngc_core_chr_check_num=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000011'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000011 should be assigned!' ).



    mo_cut->if_ngc_classification~delete_numeric_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype                 = '300'
                                       charcinternalid           = '0000000011'
                                       charcvaluedependency      = '1'
                                       charcfromdecimalvalue     = '10'
                                       charctodecimalvalue       = ''
                                       charcfromnumericvalueunit = 'KG'
                                       charctonumericvalueunit   = '' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( ) ).
    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000011'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000011 should not be assigned!' ).


  ENDMETHOD.


  METHOD delete_date_value.

    th_ngc_chr_check_factory_inj=>set_value_check(
      iv_charc_data_type = if_ngc_c=>gc_charcdatatype-date
      io_value_check     = ltd_ngc_core_chr_check_date=>get_instance( )
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000012'.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Value for characteristic 0000000012 should be assigned!' ).


    mo_cut->if_ngc_classification~delete_date_value(
      EXPORTING
        it_change_value   = VALUE #( ( classtype            = '300'
                                       charcinternalid      = '0000000012'
                                       charcvaluedependency = '1'
                                       charcfromdate        = '20180502'
                                       charctodate          = '' ) )
      IMPORTING
        eo_clf_api_result = lo_clf_api_result
        et_success_value  = DATA(lt_success_value)
    ).

    cl_abap_unit_assert=>assert_initial( act = lo_clf_api_result->get_messages( ) ).
    cl_abap_unit_assert=>assert_not_initial( lt_success_value ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = lt_valuation_data
        eo_clf_api_result = lo_clf_api_result
    ).

    READ TABLE lt_valuation_data TRANSPORTING NO FIELDS WITH KEY charcinternalid = '0000000012'.
    cl_abap_unit_assert=>assert_not_initial( act = sy-subrc
                                             msg = 'Value for characteristic 0000000012 should not be assigned!' ).


  ENDMETHOD.


  METHOD change_values_existing_value.

    DATA:
      lt_change_value TYPE ngct_valuation_charcvalue_chg.

    lt_change_value =  VALUE #( ( classtype       = '300'
                                  charcinternalid = '0000000014'
                                  charcvaluenew   = 'VALUE01' )
                                ( classtype       = '300'
                                  charcinternalid = '0000000014'
                                  charcvaluenew   = 'VALUE02' ) ).

    " Given that for a multi-value characteristic there is an already
    " assigned value, 'VALUE02'.
    " When the value assignment is called with only the new value filled.
    mo_cut->if_ngc_classification~change_values(
      EXPORTING
        it_change_value   = lt_change_value
      IMPORTING
        et_change_value   = DATA(lt_change_value_out)
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data_after)
        eo_clf_api_result = DATA(lo_clf_api_result_get_aft)
    ).
    DELETE lt_valuation_data_after WHERE charcinternalid <> '0000000014'.

    " Then there is no error message, and the already assigned value is not
    " modified.
    cl_abap_unit_assert=>assert_false( lo_clf_api_result_get_aft->has_message( ) ).
    cl_abap_unit_assert=>assert_false( lo_clf_api_result->has_message( ) ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_change_value
      exp = lt_change_value_out
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_valuation_data_after )
      exp = 2
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_valuation_data_after[ 1 ]-charcvalue
      exp = 'VALUE01'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_valuation_data_after[ 2 ]-charcvalue
      exp = 'VALUE02'
    ).

  ENDMETHOD.


  METHOD get_assigned_classes.

    assert_clf_instance_bound( ).

    mo_cut->if_ngc_classification~get_assigned_classes( IMPORTING et_classification_data = DATA(lt_classification_data_act)
                                                                  et_assigned_class      = DATA(lt_assigned_class_act) ).

    assert_clf_data_eq_testdata( lt_classification_data_act ).

    assert_assgnd_cls_eq_testdata( lt_assigned_class_act ).

  ENDMETHOD.


  METHOD get_classification_key.

    assert_clf_instance_bound( ).

    DATA(ls_classification_key) = mo_cut->if_ngc_classification~get_classification_key( ).

    cl_abap_unit_assert=>assert_equals( act = ls_classification_key
                                        exp = lth_ngc_clf_testdata=>gs_classification_key
                                        msg = 'GET_CLASSIFICATION_KEY returned with unexpected data' ).

  ENDMETHOD.


  METHOD assign_new_class.

    DATA: lt_class TYPE ngct_class_object.
    DATA: lt_classification_data_exp TYPE ngct_classification_data.

    assert_clf_instance_bound( ).

    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                          key_date        = '20170210'
                          class_object    = NEW ltd_ngc_cls( lth_ngc_clf_testdata=>gs_new_class ) ) ).

    lt_classification_data_exp = lth_ngc_clf_testdata=>gt_classification_data.
    APPEND VALUE #( classinternalid       = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                    class                 = lth_ngc_clf_testdata=>gs_new_class-class
                    classtype             = lth_ngc_clf_testdata=>gs_new_class-classtype
                    clfnstatus            = '1'
                    clfnstatusdescription = 'Released'
                    classpositionnumber   = '0'
                    classisstandardclass  = abap_false ) TO lt_classification_data_exp.
    SORT lt_classification_data_exp ASCENDING BY classtype classpositionnumber classinternalid.


    mo_cut->if_ngc_classification~assign_classes(
      EXPORTING it_class          = lt_class
      IMPORTING eo_clf_api_result = DATA(lo_clf_api_result) ).

    assert_val_classtype_contains( iv_classtype              = lth_ngc_clf_testdata=>gs_new_class-classtype
                                   it_validation_class_types = mo_cut->if_ngc_clf_validation_dp~get_validation_class_types( ) ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    mo_cut->if_ngc_classification~get_assigned_classes(
      IMPORTING et_classification_data = DATA(lt_classification_data_act)
                et_assigned_class      = DATA(lt_assigned_class_act) ).


    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_act
                                        exp = lt_classification_data_exp
                                        msg = 'Get_assigned_classes returned with unexpected data' ).

    assert_assgnd_cls_cont_new_cls( lt_assigned_class_act ).

  ENDMETHOD.


  METHOD assign_new_class_by_int_key.

    DATA: lt_classification_data_exp TYPE ngct_classification_data.

    assert_clf_instance_bound( ).

    lt_classification_data_exp = lth_ngc_clf_testdata=>gt_classification_data.
    APPEND VALUE #( classinternalid       = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                    class                 = lth_ngc_clf_testdata=>gs_new_class-class
                    classtype             = lth_ngc_clf_testdata=>gs_new_class-classtype
                    clfnstatus            = '1'
                    clfnstatusdescription = 'Released'
                    classpositionnumber   = '0'
                    classisstandardclass  = abap_false ) TO lt_classification_data_exp.
    SORT lt_classification_data_exp ASCENDING BY classtype classpositionnumber classinternalid.


    mo_cut->if_ngc_classification~assign_classes_by_int_key(
      EXPORTING
        it_class_int_key  = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                                       key_date        = '20170210' ) )
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    assert_val_classtype_contains( iv_classtype              = lth_ngc_clf_testdata=>gs_new_class-classtype
                                   it_validation_class_types = mo_cut->if_ngc_clf_validation_dp~get_validation_class_types( ) ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    mo_cut->if_ngc_classification~get_assigned_classes(
      IMPORTING et_classification_data = DATA(lt_classification_data_act)
                et_assigned_class      = DATA(lt_assigned_class_act) ).


    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_act
                                        exp = lt_classification_data_exp
                                        msg = 'Get_assigned_classes returned with unexpected data' ).

    assert_assgnd_cls_cont_new_cls( lt_assigned_class_act ).

  ENDMETHOD.

  METHOD assign_new_class_by_ext_key.

    DATA: lt_classification_data_exp TYPE ngct_classification_data.

    assert_clf_instance_bound( ).

    lt_classification_data_exp = lth_ngc_clf_testdata=>gt_classification_data.
    APPEND VALUE #( classinternalid       = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                    class                 = lth_ngc_clf_testdata=>gs_new_class-class
                    classtype             = lth_ngc_clf_testdata=>gs_new_class-classtype
                    clfnstatus            = '1'
                    clfnstatusdescription = 'Released'
                    classpositionnumber   = '0'
                    classisstandardclass  = abap_false ) TO lt_classification_data_exp.
    SORT lt_classification_data_exp ASCENDING BY classtype classpositionnumber classinternalid.


    mo_cut->if_ngc_classification~assign_classes_by_ext_key(
      EXPORTING
        it_class_ext_key  = VALUE #( ( class     = lth_ngc_clf_testdata=>gs_new_class-class
                                       classtype = lth_ngc_clf_testdata=>gs_new_class-classtype
                                       key_date  = '20170210' ) )
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result)
    ).

    assert_val_classtype_contains( iv_classtype              = lth_ngc_clf_testdata=>gs_new_class-classtype
                                   it_validation_class_types = mo_cut->if_ngc_clf_validation_dp~get_validation_class_types( ) ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    mo_cut->if_ngc_classification~get_assigned_classes(
      IMPORTING et_classification_data = DATA(lt_classification_data_act)
                et_assigned_class      = DATA(lt_assigned_class_act) ).


    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_act
                                        exp = lt_classification_data_exp
                                        msg = 'Get_assigned_classes returned with unexpected data' ).

    assert_assgnd_cls_cont_new_cls( lt_assigned_class_act ).

  ENDMETHOD.

  METHOD delete_class.

    DATA: lt_class TYPE ngct_class_object.

    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid
                          key_date        = '20170210'
                          class_object    = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object ) ).

    mo_cut->if_ngc_classification~remove_classes(
      EXPORTING it_class          = lt_class
      IMPORTING eo_clf_api_result = DATA(lo_clf_api_result) ).

    LOOP AT mo_cut->mt_valuation_data INTO DATA(ls_valuation_data)
      WHERE
        charcinternalid = '0000000014'.
      cl_abap_unit_assert=>assert_equals(
        act = ls_valuation_data-object_state
        exp = if_ngc_c=>gc_object_state-deleted
        msg = |Unexpected object state for charc { ls_valuation_data-charcinternalid } value { ls_valuation_data-charcvalue }| ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

  ENDMETHOD.

  METHOD delete_class_by_int_key.

    mo_cut->if_ngc_classification~remove_classes_by_int_key(
      EXPORTING
        it_class_int_key  = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid
                                       key_date        = '20170210' ) )
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result) ).

    LOOP AT mo_cut->mt_valuation_data INTO DATA(ls_valuation_data)
      WHERE
        charcinternalid = '0000000014'.
      cl_abap_unit_assert=>assert_equals(
        act = ls_valuation_data-object_state
        exp = if_ngc_c=>gc_object_state-deleted
        msg = |Unexpected object state for charc { ls_valuation_data-charcinternalid } value { ls_valuation_data-charcvalue }| ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

  ENDMETHOD.

  METHOD delete_class_by_ext_key.

    DATA: lt_class TYPE ngct_class_object.

    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid
                          key_date        = '20170210'
                          class_object    = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object ) ).

    mo_cut->if_ngc_classification~remove_classes_by_ext_key(
      EXPORTING
        it_class_ext_key = VALUE #( ( class     = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object->get_header( )-class
                                      classtype = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object->get_header( )-classtype
                                      key_date  = '20170210' ) )
      IMPORTING eo_clf_api_result = DATA(lo_clf_api_result) ).

    LOOP AT mo_cut->mt_valuation_data INTO DATA(ls_valuation_data)
      WHERE
        charcinternalid = '0000000014'.
      cl_abap_unit_assert=>assert_equals(
        act = ls_valuation_data-object_state
        exp = if_ngc_c=>gc_object_state-deleted
        msg = |Unexpected object state for charc { ls_valuation_data-charcinternalid } value { ls_valuation_data-charcvalue }| ).
    ENDLOOP.

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

  ENDMETHOD.


  METHOD delete_then_assign_class.

    DATA: lt_class TYPE ngct_class_object.
    DATA: lt_classification_data_exp TYPE ngct_classification_data.

    assert_clf_instance_bound( ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Classification instance not bound' ).

    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid
                          key_date        = '20170210'
                          class_object    = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-class_object ) ).

    lt_classification_data_exp = lth_ngc_clf_testdata=>gt_classification_data.
    READ TABLE lt_classification_data_exp ASSIGNING FIELD-SYMBOL(<ls_classification_data_exp>)
      WITH KEY classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid.
    ASSERT sy-subrc = 0. " lth_ngc_clf_testdata=>gt_classification_data is hard-coded
    <ls_classification_data_exp>-classpositionnumber = '10'. " after delete and assign, we will initialize class position number to 10!

    mo_cut->if_ngc_classification~remove_classes(
      EXPORTING it_class          = lt_class
      IMPORTING eo_clf_api_result = DATA(lo_clf_api_result) ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    mo_cut->if_ngc_classification~assign_classes(
      EXPORTING it_class          = lt_class
      IMPORTING eo_clf_api_result = lo_clf_api_result ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    assert_val_classtype_contains( iv_classtype              = '300'
                                   it_validation_class_types = mo_cut->if_ngc_clf_validation_dp~get_validation_class_types( ) ).

    mo_cut->if_ngc_classification~get_assigned_classes(
      IMPORTING et_classification_data = DATA(lt_classification_data_act)
                et_assigned_class      = DATA(lt_assigned_class_act) ).


    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_act
                                        exp = lt_classification_data_exp
                                        msg = 'Get_assigned_classes returned with unexpected data' ).

    assert_assgnd_cls_eq_testdata( lt_assigned_class_act ).

  ENDMETHOD.


  METHOD assign_then_delete_class.

    DATA: lt_class TYPE ngct_class_object.

    assert_clf_instance_bound( ).

    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                          key_date        = '20170210'
                          class_object    = NEW ltd_ngc_cls( lth_ngc_clf_testdata=>gs_new_class ) ) ).

    mo_cut->if_ngc_classification~assign_classes(
      EXPORTING it_class          = lt_class
      IMPORTING eo_clf_api_result = DATA(lo_clf_api_result) ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    mo_cut->if_ngc_classification~remove_classes(
      EXPORTING it_class          = lt_class
      IMPORTING eo_clf_api_result = lo_clf_api_result ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    assert_val_classtype_contains( iv_classtype              = lth_ngc_clf_testdata=>gs_new_class-classtype
                                   it_validation_class_types = mo_cut->if_ngc_clf_validation_dp~get_validation_class_types( ) ).

    mo_cut->if_ngc_classification~get_assigned_classes( IMPORTING et_classification_data = DATA(lt_classification_data_act)
                                                                  et_assigned_class      = DATA(lt_assigned_class_act) ).

    assert_clf_data_eq_testdata( lt_classification_data_act ).

    assert_assgnd_cls_eq_testdata( lt_assigned_class_act ).

  ENDMETHOD.


  METHOD load_then_modify_clf_data.

    DATA: lt_classification_data_mod TYPE ngct_classification_data_mod.
    DATA: lt_classification_data_exp TYPE ngct_classification_data.

    assert_clf_instance_bound( ).

    APPEND VALUE #( classinternalid     = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid
                    clfnstatus          = '2'
                    classpositionnumber = '321' ) TO lt_classification_data_mod.

    mo_cut->if_ngc_classification~modify_classification_data(
      EXPORTING it_classification_data_mod = lt_classification_data_mod
      IMPORTING eo_clf_api_result          = DATA(lo_clf_api_result) ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    assert_val_classtype_contains( iv_classtype              = '300'
                                   it_validation_class_types = mo_cut->if_ngc_clf_validation_dp~get_validation_class_types( ) ).

    mo_cut->if_ngc_classification~get_assigned_classes(
      IMPORTING et_classification_data = DATA(lt_classification_data_act)
                et_assigned_class      = DATA(lt_assigned_class_act) ).

    lt_classification_data_exp = lth_ngc_clf_testdata=>gt_classification_data.
    READ TABLE lt_classification_data_exp ASSIGNING FIELD-SYMBOL(<ls_classification_data_exp>)
      WITH KEY classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid.
    ASSERT sy-subrc = 0. " GT_CLASSIFICATION_DATA is hard-coded
    <ls_classification_data_exp>-clfnstatus = '2'.
    <ls_classification_data_exp>-classpositionnumber = '321'.

    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_act
                                        exp = lt_classification_data_exp
                                        msg = 'get_assigned_classes returned with unexpected data' ).

    assert_assgnd_cls_eq_testdata( lt_assigned_class_act ).

  ENDMETHOD.


  METHOD assign_then_modify_clf_data.

    DATA: lt_class TYPE ngct_class_object.
    DATA: lt_classification_data_mod TYPE ngct_classification_data_mod.
    DATA: lt_classification_data_exp TYPE ngct_classification_data.

    assert_clf_instance_bound( ).

    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                          key_date        = '20170210'
                          class_object    = NEW ltd_ngc_cls( lth_ngc_clf_testdata=>gs_new_class ) ) ).


    APPEND VALUE #( classinternalid     = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                    clfnstatus          = '2'
                    classpositionnumber = '321' ) TO lt_classification_data_mod.

    mo_cut->if_ngc_classification~assign_classes(
      EXPORTING it_class          = lt_class
      IMPORTING eo_clf_api_result = DATA(lo_clf_api_result) ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    mo_cut->if_ngc_classification~modify_classification_data(
      EXPORTING it_classification_data_mod = lt_classification_data_mod
      IMPORTING eo_clf_api_result          = lo_clf_api_result ).

    cl_abap_unit_assert=>assert_false( act = lo_clf_api_result->has_message( )
                                       msg = 'Assign_classes returned with unexpected data' ).

    assert_val_classtype_contains( iv_classtype              = lth_ngc_clf_testdata=>gs_new_class-classtype
                                   it_validation_class_types = mo_cut->if_ngc_clf_validation_dp~get_validation_class_types( ) ).

    mo_cut->if_ngc_classification~get_assigned_classes(
      IMPORTING et_classification_data = DATA(lt_classification_data_act)
                et_assigned_class      = DATA(lt_assigned_class_act) ).

    lt_classification_data_exp = lth_ngc_clf_testdata=>gt_classification_data.
    APPEND VALUE #( classinternalid       = lth_ngc_clf_testdata=>gs_new_class-classinternalid
                    class                 = lth_ngc_clf_testdata=>gs_new_class-class
                    classtype             = lth_ngc_clf_testdata=>gs_new_class-classtype
                    clfnstatus            = '2'
                    clfnstatusdescription = 'Released'
                    classpositionnumber   = '321'
                    classisstandardclass  = abap_false ) TO lt_classification_data_exp.
    SORT lt_classification_data_exp ASCENDING BY classtype classinternalid.


    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_act
                                        exp = lt_classification_data_exp
                                        msg = 'get_assigned_classes returned with unexpected data' ).

    assert_assgnd_cls_cont_new_cls( lt_assigned_class_act ).

  ENDMETHOD.


  METHOD set_get_updated_data.

    DATA: lt_classification_data_upd_exp TYPE ngct_classification_data_upd,
          lt_assigned_classes_upd_exp    TYPE ngct_class_object_upd.

    assert_clf_instance_bound( ).

    mo_cut->if_ngc_classification~get_updated_data(
      IMPORTING
        et_classification_data_upd = DATA(lt_classification_data_upd)
        et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

    DELETE lt_classification_data_upd WHERE classinternalid = lth_ngc_clf_testdata=>gt_classification_data[ 1 ]-classinternalid.
    DELETE lt_assigned_classes_upd WHERE classinternalid = lth_ngc_clf_testdata=>gt_assigned_classes[ 1 ]-classinternalid.

    mo_cut->if_ngc_clf_validation_dp~set_updated_data( it_classification_data_upd = lt_classification_data_upd
                                                       it_assigned_class_upd      = lt_assigned_classes_upd ).

    lt_classification_data_upd_exp = lt_classification_data_upd.
    lt_assigned_classes_upd_exp = lt_assigned_classes_upd.

    CLEAR: lt_classification_data_upd, lt_assigned_classes_upd.
    mo_cut->if_ngc_classification~get_updated_data(
      IMPORTING
        et_classification_data_upd = lt_classification_data_upd
        et_assigned_class_upd      = lt_assigned_classes_upd ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification_data_upd
                                        exp = lt_classification_data_upd_exp
                                        msg = 'GET_UPDATE_DATA returned with unexpected data' ).

    cl_abap_unit_assert=>assert_equals( act = lt_assigned_classes_upd
                                        exp = lt_assigned_classes_upd_exp
                                        msg = 'GET_UPDATE_DATA returned with unexpected data' ).

  ENDMETHOD.

  METHOD get_characteristics_by_cltype.

    mo_cut->if_ngc_classification~get_characteristics( EXPORTING iv_classtype      = '300'
                                                       IMPORTING et_characteristic = DATA(rt_characteristics) ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( rt_characteristics )
      exp = 10
      msg = 'Incorrect characteristics' ).

  ENDMETHOD.

  METHOD get_characteristics_by_char.

    mo_cut->if_ngc_classification~get_characteristics(
      EXPORTING iv_classtype       = '300'
                iv_charcinternalid = '0000000001'
      IMPORTING et_characteristic  = DATA(rt_characteristic) ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( rt_characteristic )
      exp = 1
      msg = 'Incorrect characteristic (for one characteristic)' ).

  ENDMETHOD.

  METHOD get_valuation_all.

    DATA(lv_lines) = lines( mo_cut->mt_valuation_data_h ).
    mo_cut->if_ngc_classification~get_assigned_values(
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data) ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_valuation_data )
      exp = lv_lines
      msg = 'Incorrect characteristic (for all characteristic)' ).

  ENDMETHOD.

  METHOD get_valuation_by_cltype.

    DATA(lt_valuation_data_exp) = mo_cut->mt_valuation_data_h.
    DELETE lt_valuation_data_exp WHERE classtype <> '300'.
    DATA(lv_lines) = lines( lt_valuation_data_exp ).
    mo_cut->if_ngc_classification~get_assigned_values(
      EXPORTING
        iv_classtype      = '300'
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data) ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_valuation_data )
      exp = lv_lines
      msg = 'Incorrect characteristic (for a class type)' ).

  ENDMETHOD.

  METHOD reference_characteristic.
*    " class DEP_NEW_CL (0000006001) with 2 characteristic,
*    " this class is not assigned to object PB_MAT_FOR_REF (GT_ASSIGNED_CLASSES) yet
*    " first characteristic (0000000105) is a new one not used in other classes,
*    " the second one (0000000001) is assigned already to class (0000005905) of class
*    " type 001,
*    " preparation: set up reference data (MARA/MAKT) within the object PB_MAT_FOR_REF,
*    " to be tested: set the reference data for retrived characteristics (3),
*    " the characteritic with reference data can be overwritten (4.a), no reference data
*    " filled in case the correponding data is not set (MARA set, though CABN requested)
*    " (4.b), read only field is set for the reference characteristic (negative/positive
*    " test) (5), assign new class (6)
*
*    DATA: lr_mara         TYPE REF TO mara,
*          lr_makt         TYPE REF TO makt,
*          lt_change_value TYPE ngct_valuation_charcvalue_chg,
*          lt_class        TYPE ngct_class_object.
*
*    assert_clf_instance_bound( ).
*
*    " 1) create reference data for mara & set in clf class
*    CREATE DATA lr_mara TYPE mara.
*    ASSIGN lr_mara->* TO FIELD-SYMBOL(<ls_mara>).
*    <ls_mara> = VALUE mara( matnr = 'PB_MAT_FOR_REF'
*                            meins = 'EA'
*                            vpsta = 'KC'
*                            pstat = 'KC'
*                            mtart = 'XXXX'
*    ).
*    mo_cut->if_ngc_classification~set_reference_data(
*      EXPORTING
*        iv_charcreferencetable = 'MARA'
*        ir_data                = lr_mara
*    ).
*
*    " 2) create reference data for makt & set in clf class
*    CREATE DATA lr_makt TYPE makt.
*    ASSIGN lr_makt->* TO FIELD-SYMBOL(<ls_makt>).
*    <ls_makt> = VALUE makt( matnr = 'PB_MAT_FOR_REF'
*                            spras = 'E'
*                            maktx = 'test reference charc'
*                            maktg = 'TEST REFERENCE CHARC'
*    ).
*    mo_cut->if_ngc_classification~set_reference_data(
*      EXPORTING
*        iv_charcreferencetable = 'MAKT'
*        ir_data                = lr_makt
*    ).
*
*    " 3) check reference characteristic value in valuation data
*    " 0000000100: the charcvalue should be set to PB_MAT_FOR_REF (instead of XYZ)
*    " 0000000101: no change (ABC)
*    mo_cut->if_ngc_classification~get_assigned_values(
*      EXPORTING
*        iv_classtype      =  'PB1'
*      IMPORTING
*        et_valuation_data = DATA(lt_valuation_data)
*    ).
*
*    READ TABLE lt_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>)
*    WITH KEY charcinternalid = '0000000100'.
*
*    cl_abap_unit_assert=>assert_equals(
*      act = <ls_valuation_data>-charcvalue
*      exp = 'XYZ'
*      msg = 'Incorrect reference characteristic value' ).
*
*    " 4) check whether a reference characteristic can be overwritten directly
*    " 4.a) 0000000100: act as reference characteristic
*    lt_change_value = VALUE #(
*      ( classtype = 'PB1' charcinternalid = '0000000100' charcvalueold = 'PB_MAT_FOR_REF' charcvaluenew = 'AAAA'  )
*    ).
*    mo_cut->if_ngc_classification~change_values(
*      EXPORTING
*        it_change_value   = lt_change_value
*      IMPORTING
*        eo_clf_api_result = DATA(lo_clf_api_result)
*    ).
*    DATA(lt_message) = lo_clf_api_result->get_messages(
*      iv_message_type = 'E'
*    ).
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( lt_message )
*      exp = 1
*      msg = 'Missing error message to prevent reference characteristic overwrite'
*    ).
*
*    " 4.b) 0000000101: despite the referece table and field setting there is no additional
*    "                  data entered, it is not handled as reference characteristic
*    lt_change_value = VALUE #(
*      ( classtype = 'PB1' charcinternalid = '0000000101' charcvalueold = 'ABC' charcvaluenew = 'AAAA'  )
*    ).
*    mo_cut->if_ngc_classification~change_values(
*      EXPORTING
*        it_change_value   = lt_change_value
*      IMPORTING
*        eo_clf_api_result = lo_clf_api_result
*    ).
*    lt_message = lo_clf_api_result->get_messages(
*      iv_message_type = 'E'
*    ).
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( lt_message )
*      exp = 0
*      msg = 'Error message issued though characteristic should not be handled as reference characteristic'
*    ).
*
*    " 4.c) 0000000102: no reference characteristic - negative
*    lt_change_value = VALUE #(
*      ( classtype = 'PB1' charcinternalid = '0000000102' charcvalueold = 'DFG' charcvaluenew = 'AAAA'  )
*    ).
*    mo_cut->if_ngc_classification~change_values(
*      EXPORTING
*        it_change_value   = lt_change_value
*      IMPORTING
*        eo_clf_api_result = lo_clf_api_result
*    ).
*    lt_message = lo_clf_api_result->get_messages(
*      iv_message_type = 'E'
*    ).
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( lt_message )
*      exp = 0
*      msg = 'Error message issued though characteristic is not reference characteristic'
*    ).
*
*    " 5)check referece characteristic read only status
*    " 5.a) 0000000100: reference characteristic
*    mo_cut->if_ngc_classification~get_characteristics(
*      EXPORTING
*        iv_classtype       = 'PB1'
*        iv_charcinternalid = '0000000100'
*      IMPORTING
*        et_characteristic  = DATA(lt_characteristic)
*    ).
*    READ TABLE lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_character>)
*    WITH KEY charcinternalid = '0000000100'.
*    DATA(ls_character_header) = <ls_character>-characteristic_object->get_header( ).
*    cl_abap_unit_assert=>assert_equals(
*      act = ls_character_header-charcisreadonly
*      exp = abap_true
*      msg = 'Read only field is not set in case of reference characteristic'
*    ).
*
*    " 5.b) 0000000101: not handled as reference characteristic
*    mo_cut->if_ngc_classification~get_characteristics(
*      EXPORTING
*        iv_classtype       = 'PB1'
*        iv_charcinternalid = '0000000101'
*      IMPORTING
*        et_characteristic  = lt_characteristic
*    ).
*    READ TABLE lt_characteristic ASSIGNING <ls_character>
*    WITH KEY charcinternalid = '0000000101'.
*    ls_character_header = <ls_character>-characteristic_object->get_header( ).
*    cl_abap_unit_assert=>assert_equals(
*      act = ls_character_header-charcisreadonly
*      exp = abap_false
*      msg = 'Read only field is not set in case of characteristic (not handled as reference)'
*    ).
*
*    " 5.c) get characteristic for class type PB1
*    mo_cut->if_ngc_classification~get_characteristics(
*      EXPORTING
*        iv_classtype       = 'PB1'
*      IMPORTING
*        et_characteristic  = lt_characteristic
*    ).
*    DATA(lv_count) = 0.
*    LOOP AT lt_characteristic ASSIGNING <ls_character>.
*      ls_character_header = <ls_character>-characteristic_object->get_header( ).
*      IF ls_character_header-charcisreadonly = abap_true.
*        lv_count = lv_count + 1.
*      ENDIF.
*    ENDLOOP.
*    cl_abap_unit_assert=>assert_equals(
*      act = lv_count
*      exp = 1
*      msg = 'Read only field is not set in case of characteristic (for class type)'
*    ).
*
*    " 5.d) get all characteristics
*    mo_cut->if_ngc_classification~get_characteristics(
*      IMPORTING
*        et_characteristic  = lt_characteristic
*    ).
*    lv_count = 0.
*    LOOP AT lt_characteristic ASSIGNING <ls_character>.
*      ls_character_header = <ls_character>-characteristic_object->get_header( ).
*      IF ls_character_header-charcisreadonly = abap_true.
*        lv_count = lv_count + 1.
*      ENDIF.
*    ENDLOOP.
*    cl_abap_unit_assert=>assert_equals(
*      act = lv_count
*      exp = 1
*      msg = 'Read only field is not set in case of characteristic (all characteristics)'
*    ).
*
*
*    " 6.a) assign new class: set reference data in valuation with (0000000104)
*    "     and without (0000000106) reference table
*    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class_ref-classinternalid
*                          key_date        = '20170210'
*                          class_object    = NEW ltd_ngc_cls( is_header = lth_ngc_clf_testdata=>gs_new_class_ref
*                                                             it_class_characteristics = lth_ngc_clf_testdata=>gt_new_charc_ref )
*                       ) ).
*
*    mo_cut->if_ngc_classification~assign_classes(
*      EXPORTING it_class          = lt_class
*      IMPORTING eo_clf_api_result = lo_clf_api_result ).
*
*    READ TABLE mo_cut->mt_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation>)
*    WITH KEY charcinternalid = '0000000104'.
*    IF sy-subrc <> 0.
*      cl_abap_unit_assert=>fail(
*        EXPORTING
*          msg    = 'Valuation data of reference characteristic is not created'
*      ).
*    ELSE.
*      cl_abap_unit_assert=>assert_equals(
*        act = <ls_valuation>-charcvalue
*        exp = 'PB_MAT_FOR_REF'
*        msg = 'Reference data is not set for valuation data of reference characteristic'
*      ).
*    ENDIF.
*    " 6.b) assign new class: set valuation for characteristic without reference data (0000000106)
*    lt_change_value = VALUE #(
*      ( classtype = 'PB1' charcinternalid = '0000000106' charcvalueold = '' charcvaluenew = 'VALUATION_WO_REF_TABLE'  )
*    ).
*    mo_cut->if_ngc_classification~change_values(
*      EXPORTING
*        it_change_value   = lt_change_value
*      IMPORTING
*        eo_clf_api_result = lo_clf_api_result
*    ).
*    READ TABLE mo_cut->mt_valuation_data ASSIGNING <ls_valuation>
*    WITH KEY charcinternalid = '0000000106'.
*    IF sy-subrc <> 0.
*      cl_abap_unit_assert=>fail(
*        EXPORTING
*          msg    = 'Valuation data for characteristic without reference table is not created'
*      ).
*    ELSE.
*      cl_abap_unit_assert=>assert_equals(
*        act = <ls_valuation>-charcvalue
*        exp = 'VALUATION_WO_REF_TABLE'
*        msg = 'Reference data is not set for valuation data of reference characteristic'
*      ).
*    ENDIF.
*
***********************************************************************
***    " 7) delete reference data within test object -> not required right now
***    CLEAR: mo_cut->mt_reference_data.
***********************************************************************

  ENDMETHOD.

  METHOD dependency_assign_remove_class.
    " class DEP_NEW_CL (0000006001) with 2 characteristic,
    " this class is not assigned to object TEST_FOCUS_OBJECT (GT_ASSIGNED_CLASSES) yet
    " first characteristic (0000000105) is a new one not used in other classes,
    " the second one (0000000001) is assigned already to class (0000005905) of class
    " type 001,
    " to be tested: assign the class to the object, set valuation for both characteristic
    " and remove the class

    DATA: lt_change_value TYPE ngct_valuation_charcvalue_chg,
          lt_class        TYPE ngct_class_object.

    assert_clf_instance_bound( ).

    " 1) assign class
    lt_class = VALUE #(
      ( classinternalid = lth_ngc_clf_testdata=>gs_new_class_dep-classinternalid
        key_date        = '20170210'
        class_object    = NEW ltd_ngc_cls(
          is_header                = lth_ngc_clf_testdata=>gs_new_class_dep
          it_class_characteristics = lth_ngc_clf_testdata=>gt_new_charc_dep )
      )
    ).
    mo_cut->if_ngc_classification~assign_classes(
      EXPORTING it_class          = lt_class
    ).

    " 2) set valuation
    lt_change_value = VALUE #(
      ( classtype = 'PB1' charcinternalid = '0000000105' charcvalueold = '' charcvaluenew = 'AAA'  )
      ( classtype = 'PB1' charcinternalid = '0000000001' charcvalueold = '' charcvaluenew = 'TEST_VALUE_AAA'  )
    ).
    mo_cut->if_ngc_classification~change_values(
      EXPORTING
        it_change_value   = lt_change_value
    ).

    " 3) remove class with characteristic and valuation data
    mo_cut->if_ngc_classification~remove_classes(
      EXPORTING
        it_class          =  lt_class
    ).

    " 4) check valuation data for the new characteristic
    READ TABLE mo_cut->mt_valuation_data_h ASSIGNING FIELD-SYMBOL(<ls_valuation>)
    WITH KEY charcinternalid = '0000000105'
             classtype       = 'PB1'.
    IF sy-subrc = 0.
      cl_abap_unit_assert=>fail(
        EXPORTING
          msg    = 'Valuation data of removed class is still available'
      ).
    ENDIF.

    READ TABLE mo_cut->mt_valuation_data_h ASSIGNING <ls_valuation>
    WITH KEY charcinternalid = '0000000001'
             classtype       = 'PB1'.
    IF sy-subrc = 0.
      cl_abap_unit_assert=>fail(
        EXPORTING
          msg    = 'Valuation data of removed class is still available'
      ).
    ENDIF.

    READ TABLE mo_cut->mt_valuation_data_h ASSIGNING <ls_valuation>
    WITH KEY charcinternalid = '0000000001'.
    IF sy-subrc <> 0.
      cl_abap_unit_assert=>fail(
        EXPORTING
          msg    = 'Valuation data of assigned class is not available'
      ).
    ENDIF.

  ENDMETHOD.

  METHOD dependency_remove_class.
    " class DEP_REMOVE_CL (0000006002) with 2 characteristic,
    " this class assigned to object TEST_FOCUS_OBJECT (GT_ASSIGNED_CLASSES)
    " first characteristic (0000000107) is already valuated,
    " the second one (0000000108) is not valuated
    " to be tested: set valuation for the characterisitcs and remove the
    " from the object

    DATA: lt_change_value TYPE ngct_valuation_charcvalue_chg,
          lt_class        TYPE ngct_class_object.

    assert_clf_instance_bound( ).

    " 1) create class object for class DEP_REMOVE_CL (0000006002)
    lt_class = VALUE #(
      ( classinternalid = lth_ngc_clf_testdata=>gs_class_remove-classinternalid " '0000006002'
        key_date        = '20170210'
        class_object    = NEW ltd_ngc_cls(
          is_header                = lth_ngc_clf_testdata=>gs_class_remove
          it_class_characteristics = lth_ngc_clf_testdata=>gt_charc_remove )
      )
    ).

    " 2) set & change valuation for characteristic of class DEP_REMOVE_CL (0000006002)
    lt_change_value = VALUE #(
      ( classtype = 'PB1' charcinternalid = '0000000107' charcvalueold = 'ASSIGNED_VALUE' charcvaluenew = 'REWRITTEN_VALUE'  )
      ( classtype = 'PB1' charcinternalid = '0000000108' charcvalueold = '' charcvaluenew = 'ASSIGN_NEW_VALUE'  )
    ).
    mo_cut->if_ngc_classification~change_values(
      EXPORTING
        it_change_value   = lt_change_value
    ).

    " 3) remove  DEP_REMOVE_CL (0000006002) with characteristic and valuation data
    mo_cut->if_ngc_classification~remove_classes(
      EXPORTING
        it_class          =  lt_class
    ).

    " 4) check whether te newly valuation data of class DEP_REMOVE_CL (0000006002) was
    " deleted from table
    READ TABLE mo_cut->mt_valuation_data_h ASSIGNING FIELD-SYMBOL(<ls_valuation>)
    WITH KEY charcinternalid = '0000000108'
             classtype       = 'PB1'.
    IF sy-subrc = 0.
      cl_abap_unit_assert=>fail(
        EXPORTING
          msg    = 'Valuation data of removed class is still available'
      ).
    ENDIF.

    " 5) check whether the old valuated data of class DEP_REMOVE_CL (0000006002) marked
    " as deleted
    READ TABLE mo_cut->mt_valuation_data_h ASSIGNING <ls_valuation>
    WITH KEY charcinternalid = '0000000107'
             classtype       = 'PB1'
             object_state    = if_ngc_c=>gc_object_state-deleted.
    IF sy-subrc <> 0.
      cl_abap_unit_assert=>fail(
        EXPORTING
          msg    = 'Valuation data of removed class is not marked as deleted'
      ).
    ENDIF.

    " 6) check assigned class (class DEP_REMOVE_CL (0000006002) should be marked as deleted)
    READ TABLE mo_cut->mt_assigned_class TRANSPORTING NO FIELDS
    WITH KEY classinternalid = lth_ngc_clf_testdata=>gs_class_remove-classinternalid " '0000006002'
             object_state    = if_ngc_c=>gc_object_state-deleted.
    IF sy-subrc <> 0.
      cl_abap_unit_assert=>fail(
        EXPORTING
          msg    = 'Removed class is not marked as deleted'
      ).
    ENDIF.

  ENDMETHOD.

  METHOD assign_already_assigned_class.

    DATA:  lt_class        TYPE ngct_class_object.

    assert_clf_instance_bound( ).

    lt_class = VALUE #( ( classinternalid = lth_ngc_clf_testdata=>gs_new_class_duplicate-classinternalid
                          key_date        = '20170210'
                          class_object    = NEW ltd_ngc_cls( is_header = lth_ngc_clf_testdata=>gs_new_class_duplicate
                                                             it_class_characteristics = VALUE #( ) )
                   ) ).
    mo_cut->if_ngc_classification~assign_classes(
      EXPORTING
        it_class          = lt_class
      IMPORTING
        eo_clf_api_result =  DATA(lo_clf_api_result)
    ).
    DATA(lt_message) = lo_clf_api_result->get_messages(
      iv_message_type = 'E'
    ).
    READ TABLE lt_message TRANSPORTING NO FIELDS
    WITH KEY object_key       = lth_ngc_clf_testdata=>gs_classification_key-object_key
             technical_object = lth_ngc_clf_testdata=>gs_classification_key-technical_object
             key_date         = lth_ngc_clf_testdata=>gs_classification_key-key_date
             msgno            = '021'
             msgid            = 'NGC_API_BASE'
             msgv1            = lth_ngc_clf_testdata=>gs_new_class_duplicate-classtype
             msgv2            = lth_ngc_clf_testdata=>gs_new_class_duplicate-class
             change_number    = lth_ngc_clf_testdata=>gs_classification_key-change_number.
    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      exp = 0
      msg = 'Same class assignment: incorrect error message issued'
    ).

  ENDMETHOD.

  METHOD update_temporary_key.

    cl_abap_testdouble=>configure_call( mo_cut->mo_clf_persistency
      )->ignore_all_parameters(
      )->set_parameter(
        name  = 'et_classification'
        value = VALUE ngct_core_classification(
          ( object_key       = lth_ngc_clf_testdata=>gs_classification_key-object_key
            technical_object = lth_ngc_clf_testdata=>gs_classification_key-technical_object
            key_date         = lth_ngc_clf_testdata=>gs_classification_key-key_date ) ) ).
    mo_cut->mo_clf_persistency->read( VALUE #( ) ).

    TRY.
        mo_cut->if_ngc_classification~update_temporary_key( 'NEW_OBJECT' ).

      CATCH cx_ngc_api.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->ms_classification_key-object_key
      exp = 'NEW_OBJECT' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->ms_classification_key-technical_object
      exp = lth_ngc_clf_testdata=>gs_classification_key-technical_object ).

  ENDMETHOD.

  METHOD update_temporary_key_valuation.

    cl_abap_testdouble=>configure_call( mo_cut->mo_clf_persistency
      )->ignore_all_parameters(
      )->set_parameter(
        name  = 'et_classification'
        value = VALUE ngct_core_classification(
          ( object_key       = lth_ngc_clf_testdata=>gs_classification_key-object_key
            technical_object = lth_ngc_clf_testdata=>gs_classification_key-technical_object
            key_date         = lth_ngc_clf_testdata=>gs_classification_key-key_date
            valuation_data   = VALUE #(
              ( clfnobjectid    = lth_ngc_clf_testdata=>gs_classification_key-object_key
                charcinternalid = '0000000001' ) ) ) ) ).
    mo_cut->mo_clf_persistency->read( VALUE #( ) ).

    TRY.
        mo_cut->if_ngc_classification~update_temporary_key( 'EXISTING_OBJECT' ).

        cl_abap_unit_assert=>fail( ).

      CATCH cx_ngc_api.
        cl_abap_unit_assert=>assert_equals(
          act = mo_cut->ms_classification_key-object_key
          exp = lth_ngc_clf_testdata=>gs_classification_key-object_key ).

        cl_abap_unit_assert=>assert_equals(
          act = mo_cut->ms_classification_key-technical_object
          exp = lth_ngc_clf_testdata=>gs_classification_key-technical_object ).
    ENDTRY.

  ENDMETHOD.

  METHOD update_temporary_key_clfn.

    cl_abap_testdouble=>configure_call( mo_cut->mo_clf_persistency
      )->ignore_all_parameters(
      )->set_parameter(
        name  = 'et_classification'
        value = VALUE ngct_core_classification(
          ( object_key          = lth_ngc_clf_testdata=>gs_classification_key-object_key
            technical_object    = lth_ngc_clf_testdata=>gs_classification_key-technical_object
            key_date            = lth_ngc_clf_testdata=>gs_classification_key-key_date
            classification_data = VALUE #(
              ( classtype       = '001'
                classinternalid = '0000000001' ) ) ) ) ).
    mo_cut->mo_clf_persistency->read( VALUE #( ) ).

    TRY.
        mo_cut->if_ngc_classification~update_temporary_key( 'EXISTING_OBJECT' ).

        cl_abap_unit_assert=>fail( ).

      CATCH cx_ngc_api.
        cl_abap_unit_assert=>assert_equals(
          act = mo_cut->ms_classification_key-object_key
          exp = lth_ngc_clf_testdata=>gs_classification_key-object_key ).

        cl_abap_unit_assert=>assert_equals(
          act = mo_cut->ms_classification_key-technical_object
          exp = lth_ngc_clf_testdata=>gs_classification_key-technical_object ).
    ENDTRY.

  ENDMETHOD.

  METHOD assert_clf_instance_bound.

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Classification instance not bound' ).

  ENDMETHOD.


  METHOD assert_clf_data_eq_testdata.

    cl_abap_unit_assert=>assert_equals( act = it_classification_data
                                        exp = lth_ngc_clf_testdata=>gt_classification_data
                                        msg = 'GET_ASSIGNED_CLASSES returned with unexpected data' ).

  ENDMETHOD.


  METHOD assert_assgnd_cls_eq_testdata.

    cl_abap_unit_assert=>assert_equals( act = it_assigned_classes
                                        exp = lth_ngc_clf_testdata=>gt_assigned_classes
                                        msg = 'GET_ASSIGNED_CLASSES returned with unexpected data' ).

  ENDMETHOD.


  METHOD assert_assgnd_cls_cont_new_cls.

    cl_abap_unit_assert=>assert_equals( act = lines( it_assigned_classes )
                                        exp = 6 ).

    READ TABLE it_assigned_classes INTO DATA(ls_assigned_class_act) WITH KEY classinternalid = lth_ngc_clf_testdata=>gs_new_class-classinternalid.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                         msg = 'Get_assigned_classes returned with unexpected data' ).

    cl_abap_unit_assert=>assert_bound( act = ls_assigned_class_act-class_object
                                       msg = 'Get_assigned_classes returned with unexpected data' ).

    DATA(ls_class_header_act) = ls_assigned_class_act-class_object->get_header( ).

    cl_abap_unit_assert=>assert_equals( act = ls_class_header_act
                                        exp = lth_ngc_clf_testdata=>gs_new_class
                                        msg = 'Get_assigned_classes returned with unexpected data' ).


  ENDMETHOD.

  METHOD assert_val_classtype_contains.
    cl_abap_unit_assert=>assert_equals( act = lines( it_validation_class_types )
                                        exp = 1
                                        msg = 'Validation class types contains unexpected data' ).
    READ TABLE it_validation_class_types TRANSPORTING NO FIELDS WITH KEY table_line = iv_classtype.
    cl_abap_unit_assert=>assert_initial( act = sy-subrc
                                          msg = 'Validation class types contains unexpected data' ).
  ENDMETHOD.

ENDCLASS.