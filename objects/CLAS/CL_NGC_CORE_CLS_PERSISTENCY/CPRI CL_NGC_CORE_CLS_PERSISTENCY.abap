private section.

  types:
    BEGIN OF ts_clfnclasshiercharcforkeydat .
      INCLUDE TYPE: i_clfnclasshiercharcforkeydate.
      TYPES: key_date TYPE dats.
  TYPES: END OF ts_clfnclasshiercharcforkeydat .
  types:
    tt_clfnclasshiercharcforkeydat TYPE STANDARD TABLE OF ts_clfnclasshiercharcforkeydat .
  types:
    tt_classinternalid_range TYPE RANGE OF clint .
  types:
    ts_classinternalid_range TYPE LINE OF tt_classinternalid_range .
  types:
    BEGIN OF ts_class_int_key_with_range.
  TYPES: key_date TYPE dats.
  TYPES: classinternalid TYPE tt_classinternalid_range.
  TYPES: END OF ts_class_int_key_with_range .
  types:
    tt_class_int_key_with_range TYPE STANDARD TABLE OF ts_class_int_key_with_range WITH NON-UNIQUE KEY key_date .
  types:
    tt_class_range TYPE RANGE OF klasse_d .
  types:
    tt_classtype_range TYPE RANGE OF klassenart .
  types:
    BEGIN OF ts_class_ext_key_with_range.
  TYPES: classtype TYPE klassenart.
  TYPES: key_date TYPE dats.
  TYPES: class TYPE tt_class_range.
  TYPES: END OF ts_class_ext_key_with_range .
  types:
    tt_class_ext_key_with_range TYPE STANDARD TABLE OF ts_class_ext_key_with_range WITH NON-UNIQUE KEY classtype key_date .
  types:
    BEGIN OF ts_klah_changes .
      INCLUDE TYPE: ngcs_core_class_key AS class_key.
  TYPES: classtype                     TYPE klassenart.
  TYPES: class                         TYPE klasse_d.
  TYPES: classstatus                   TYPE klstatus.
  TYPES: classsearchauthgrp            TYPE bgrse.
  TYPES: classclassfctnauthgrp         TYPE bgrkl.
  TYPES: classmaintauthgrp             TYPE bgrkp.
  TYPES: docnumber                     TYPE doknr.
  TYPES: documenttype                  TYPE dokar.
  TYPES: documentpart                  TYPE doktl_d.
  TYPES: documentversion               TYPE dokvr.
  TYPES: sameclassfctnreaction         TYPE glklafz.
  TYPES: clfnorganizationalarea        TYPE abteilung.
  TYPES: classstandardorgname          TYPE norm.
  TYPES: classstandardnumber           TYPE normnr.
  TYPES: classstandardstartdate        TYPE ausgdt.
  TYPES: classstandardversionstartdate TYPE versdt.
  TYPES: classstandardversion          TYPE versio.
  TYPES: classstandardcharctable       TYPE leiste.
  TYPES: classislocal                  TYPE local_class.
  TYPES: validitystartdate             TYPE vondat.
  TYPES: validityenddate               TYPE bisdat.
  TYPES: keydate                       TYPE dats.
*  TYPES: classtext                     TYPE textbez.
  TYPES: classdescription              TYPE klschl.
  TYPES: classstatusname               TYPE eintext.
  TYPES: classificationisallowed       TYPE klfkz.
  TYPES: object_state                  TYPE ngc_core_object_state.
  TYPES: END OF ts_klah_changes .
  types:
    tt_klah_changes TYPE STANDARD TABLE OF ts_klah_changes WITH NON-UNIQUE DEFAULT KEY .
  types:
    BEGIN OF ts_characteristic_data .
  TYPES: classinternalid TYPE clint.
      INCLUDE TYPE: ngcs_core_charc.
  TYPES: END OF ts_characteristic_data .
  types:
    tt_characteristic_data TYPE STANDARD TABLE OF ts_characteristic_data WITH NON-UNIQUE DEFAULT KEY .
  types:
    BEGIN OF ts_clfnobjectcharcvalue .
*      INCLUDE TYPE i_clfnobjectcharcvalue .
      INCLUDE TYPE i_clfnobjectcharcvaluebasic .
      TYPES: key_date TYPE dats .
  TYPES: END OF ts_clfnobjectcharcvalue .
  types:
    tt_clfnobjectcharcvalue TYPE STANDARD TABLE OF ts_clfnobjectcharcvalue .
  types:
    BEGIN OF ts_org_area_w_auth.
      TYPES: classtype                TYPE klassenart.
      TYPES: clfnorganizationalareacode TYPE sichtkz.
    TYPES: END OF ts_org_area_w_auth .
  types:
    tt_org_area_w_auth TYPE STANDARD TABLE OF ts_org_area_w_auth .
  types:
    BEGIN OF ts_org_area_w_disp_auth.
      TYPES: classtype                  TYPE klassenart.
      TYPES: clfnorganizationalareacode   TYPE sichtkz.
      TYPES: clfnorganizationalareaname TYPE sichtbez.
    TYPES: END OF ts_org_area_w_disp_auth .
  types:
    BEGIN OF ts_classtype.
      TYPES: classtype TYPE klassenart.
    TYPES: END OF ts_classtype .
  types:
    tt_classtype TYPE STANDARD TABLE OF ts_classtype .
  types:
    tt_org_area_w_disp_auth TYPE STANDARD TABLE OF ts_org_area_w_disp_auth .
  types:
    tt_inh_keys_range TYPE RANGE OF cuobn .
  types:
    BEGIN OF ts_inh_keys_w_key_date.
  TYPES: key_date                TYPE dats.
  TYPES: ancestorclassinternalid TYPE tt_inh_keys_range.
  TYPES: END OF ts_inh_keys_w_key_date .
  types:
    tt_inh_keys_w_key_date TYPE STANDARD TABLE OF ts_inh_keys_w_key_date .
  types:
    BEGIN OF ts_class_buffer .
      TYPES: classinternalid                TYPE clint .
      TYPES: key_date                       TYPE bapi_keydate .
      TYPES: classtype                      TYPE klassenart .
      TYPES: class                          TYPE klasse_d .
      TYPES: class_data                     TYPE ngcs_core_class .
      TYPES: characteristics_data_populated TYPE boole_d .
      TYPES: characteristics_data           TYPE ngct_core_class_characteristic .
      TYPES: characteristic_values_data     TYPE ngct_core_class_charc_value .
      TYPES: characteristic_reference_data  TYPE ngct_core_charc_ref .
  types: END OF ts_class_buffer .
  types:
    tt_class_buffer TYPE STANDARD TABLE OF ts_class_buffer .

  data MT_KLAH_DATA type TT_KLAH_CHANGES .
  data MT_CHARACTERISTIC_DATA type TT_CHARACTERISTIC_DATA .
  data MT_CLASS_STATUS type NGCT_CORE_CLASS_STATUS .
  data MT_CLFNCLASSHIERCHARC type TT_CLFNCLASSHIERCHARCFORKEYDAT .
  data MT_CLFNCLASSHIERCHARCFORKEYDAT type TT_CLFNCLASSHIERCHARCFORKEYDAT .
  data MT_CLFNCHARCVALUEFORKEYDATE type NGCT_CORE_CHARC_VALUE .
  data MT_CLFNOBJECTCHARCVALUE type TT_CLFNOBJECTCHARCVALUE .
  data MT_ORG_AREA_W_DISP_AUTH type TT_ORG_AREA_W_DISP_AUTH .
  data MT_ORG_AREA_W_AUTH type TT_ORG_AREA_W_AUTH .
  data MT_CLASSTYPE type TT_CLASSTYPE .
  data:
    MT_PARENT_OBJECTCLASSBASIC type standard table of I_CLFNOBJECTCLASSBASIC .
  data MO_UTIL_INTERSECT type ref to IF_NGC_CORE_CLS_UTIL_INTERSECT .
  data MO_CHR_PERSISTENCY type ref to IF_NGC_CORE_CHR_PERSISTENCY .
  data MT_BUFFERED_DATA type TT_CLASS_BUFFER .

  methods QUERY_CHARCHIER_CLASS_EXT_KEY
    importing
      !IT_CLASS_RANGE_BY_CLASSTYPE type TT_CLASS_EXT_KEY_WITH_RANGE .
  methods QUERY_CHARCHIER_CLASS_INT_KEY
    importing
      !IT_CLASS_RANGE_BY_CLINT type TT_CLASS_INT_KEY_WITH_RANGE .
  methods GET_CHARCS_AND_VALS_RECURSIVE
    importing
      !IS_CLFNCLASSHIERCHARCFORKEYDAT type TS_CLFNCLASSHIERCHARCFORKEYDAT
    exporting
      !ES_COLLECTED_CHAR_VALUE type NGCS_CORE_CLASS_CHARC_INTER .
  methods READ_CLASS_STATUS_INT .
  methods READ_ORG_AREA
    importing
      !IT_CLASSTYPE_RANGE type TT_CLASSTYPE_RANGE .
  methods FILL_ORG_AREA
    changing
      !CT_CLASS_CHARACTERISTIC type NGCT_CORE_CLASS_CHARACTERISTIC .
  methods CHECK_ORG_AREA
    changing
      !CT_CLASS_CHARACTERISTIC type NGCT_CORE_CLASS_CHARACTERISTIC .
  methods GET_CHARCS_AND_VALS
    importing
      !IT_KEYS type NGCT_CORE_CLASS_KEY
    exporting
      !ET_CLASS_CHARACTERISTICS type NGCT_CORE_CLASS_CHARACTERISTIC
      !ET_CLASS_CHARACTERISTIC_VALUES type NGCT_CORE_CLASS_CHARC_VALUE
      !ET_CHARACTERISTIC_REFERENCE type NGCT_CORE_CHARC_REF
      !ET_MESSAGE type NGCT_CORE_CLASS_MSG .
  methods CALCULATE_INTERSECTION
    importing
      !IS_CLFNCLASSHIERCHARCFORKEYDAT type TS_CLFNCLASSHIERCHARCFORKEYDAT
      !IT_COLLECTED_CHAR_VALUES type NGCT_CORE_CLASS_CHARC_INTER
    exporting
      !ES_COLLECTED_CHAR_VALUE type NGCS_CORE_CLASS_CHARC_INTER .
  methods OVERWRITE_FIELD
    importing
      !IV_ORIGINAL_FIELD type CHAR1
      !IV_OVERWRITTEN_FIELD type CHAR1
    returning
      value(RV_FIELD) type CHAR1 .
  class-methods ADD_MESSAGES
    importing
      !IS_CORE_CLASS_KEY type NGCS_CORE_CLASS_KEY
      !IT_CORE_MESSAGE type NGCT_CORE_MSG optional
      !IT_CORE_CHARC_MESSAGE type NGCT_CORE_CHARC_MSG optional
    changing
      !CT_CORE_CLASS_MESSAGE type NGCT_CORE_CLASS_MSG .