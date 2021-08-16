private section.

  types:
    BEGIN OF ts_classtype_node_or_leaf .
    TYPES: classtype                 TYPE klassenart.
    TYPES: is_node                   TYPE boole_d.
    TYPES: parent_classification_key TYPE ngcs_classification_key.
    TYPES: child_classification_key  TYPE ngct_classification_key.
    TYPES: END OF ts_classtype_node_or_leaf .
  types:
    tt_classtype_node_or_leaf TYPE STANDARD TABLE OF ts_classtype_node_or_leaf WITH NON-UNIQUE DEFAULT KEY .
  types:
    ltt_classtype TYPE STANDARD TABLE OF klassenart WITH EMPTY KEY .

  data MO_CLF_PERSISTENCY type ref to IF_NGC_CORE_CLF_PERSISTENCY .
  data MO_CHR_PERSISTENCY type ref to IF_NGC_CORE_CHR_PERSISTENCY .
  data MS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY .
  data MT_ASSIGNED_CLASS type NGCT_CLASS_OBJECT_UPD .
  data:
    mt_classification_data TYPE HASHED TABLE OF ngcs_classification_data_upd WITH UNIQUE KEY classinternalid .
*  data MT_ASSIGNED_CLASS type hashed table of NGCS_CLASS_OBJECT_UPD with unique key CLASSINTERNALID KEY_DATE .
  data MT_VALUATION_DATA type NGCT_VALUATION_DATA_UPD .
  data:
    mt_valuation_data_h TYPE HASHED TABLE OF ngcs_valuation_data_upd WITH UNIQUE KEY clfnobjectid charcinternalid charcvaluepositionnumber classtype timeintervalnumber .    "object_state.
  data:
    mt_valuation_data_h_prev TYPE HASHED TABLE OF ngcs_valuation_data_upd WITH UNIQUE KEY clfnobjectid charcinternalid charcvaluepositionnumber classtype timeintervalnumber .      "object_state.
  data MO_CLF_VALIDATION_MANAGER type ref to CL_NGC_CLF_VALIDATION_MGR .
  data MT_VALIDATION_CLASS_TYPES type NGCT_CLASS_TYPES .
  data MO_CLF_UTIL_INTERSECT type ref to CL_NGC_CLF_UTIL_INTERSECT .
  data MO_CORE_UTIL_INTERSECT type ref to IF_NGC_CORE_CLS_UTIL_INTERSECT .
  data MO_NGC_API_FACTORY type ref to CL_NGC_API_FACTORY .
  data MO_NGC_UTIL type ref to IF_NGC_CORE_UTIL .
  data MT_REFERENCE_DATA type NGCT_CLASSIFICATION_REF_DATA .
  data MV_SKIP_CHECKS_FOR_REF_CHARC type BOOLE_D .
  data MT_CLASSTYPE type NGCT_CLASSTYPE .
  data MO_CLF_STATUS type ref to IF_NGC_CLF_STATUS .
  data MT_CLASSTYPE_NODE_OR_LEAF type TT_CLASSTYPE_NODE_OR_LEAF .
  data MO_CLF_UTIL_VALUATION type ref to CL_NGC_CLF_UTIL_VALUATION_EXT .
  data MO_CLS_PERSISTENCY type ref to IF_NGC_CORE_CLS_PERSISTENCY .
  data MV_VALUATION_HASH_TABLE type BOOLE_D value ABAP_TRUE ##NO_TEXT.

  class-methods FILL_VALUATION_DATA
    importing
      !IV_CHARC_TYPE type ATFOR
    changing
      !CS_VALUATION_DATA type NGCS_VALUATION_DATA .
  methods CHECK_SYNTAX_AND_CONVERT
    importing
      !IS_VALUE_CHANGE type NGCS_VALUATION_CHARCVALUE_CHG
      !IS_CHARC_HEADER type NGCS_CHARACTERISTIC
    exporting
      !ET_VALUATION_DATA type NGCT_VALUATION_DATA
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods GET_NEXT_CHARCVALPOSITIONNUM
    importing
      !IS_CHARACTERISTIC_HEADER type NGCS_CHARACTERISTIC
      !IV_CLASSTYPE type KLASSENART
    returning
      value(RV_CHARCVALUEPOSITIONNUMBER) type WZAEHL .
  methods GET_NEXT_CHARCVALTIMEINTERVALN
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_CLASSTYPE type KLASSENART
    returning
      value(RV_TIMEINTERVALNUMBER) type ADZHL .
  methods BUILD_STRING_ASSIGNED_VALUES
    importing
      !IS_VALUATION_DATA type NGCS_VALUATION_DATA_UPD
    exporting
      !EV_CHARCVALUE type ATWRT
      !ET_CORE_MESSAGE type NGCT_CORE_MSG .
  methods SET_REFERENCE_CHARC_HDR
    changing
      !CS_CHARACTERISTIC_HEADER type NGCS_CHARACTERISTIC .
  methods SET_REFERENCE_CHARC_VALUATION
    importing
      !IS_CLASS_OBJECT type NGCS_CLASS_OBJECT .
  methods REFRESH_CLASSTYPE_STATUSES .
  methods CALL_BADI_ASSIGN_CLASSES
    importing
      !IT_CLASS type NGCT_CLASS_OBJECT
    exporting
      !EV_ALLOWED type BOOLE_D
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods CALL_BADI_REMOVE_CLASSES
    importing
      !IT_CLASS type NGCT_CLASS_OBJECT
    exporting
      !EV_ALLOWED type BOOLE_D
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods CALL_BADI_CHANGE_VALUES
    importing
      !IT_CHANGE_VALUE type NGCT_VALUATION_CHARCVALUE_CHG
    exporting
      !EV_ALLOWED type BOOLE_D
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods CALL_BADI_NODE_LEAF
    importing
      !IV_CLASSTYPE type KLASSENART
    exporting
      !ES_PARENT_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
      !ET_CHILD_CLASSIFICATION_KEY type NGCT_CLASSIFICATION_KEY
    changing
      !CV_PROCESSING_NODE type BOOLE_D .
  methods HANDLE_CLASSTYPES_NODE_LEAF
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods SETUP_CLASSTYPES_NODE_LEAF .
  methods CHECK_CHANGE_VALUES
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT
      !ET_SUCCESS_INDEX type INT4_TABLE
    changing
      !CT_CHANGE_VALUE_I type NGCT_VALUATION_CHARCVALUE_CHGI .
  methods UPDATE_VALUATION_DATA_BUFFER
    importing
      !IS_CHANGE_VALUE_ATWRT_I type NGCS_VALUATION_CHARCVALUE_CHGI
      !IS_CHARC_HEADER type NGCS_CHARACTERISTIC
    changing
      !CS_NEW_VALUATION_DATA type NGCS_VALUATION_DATA optional .
  methods CHANGE_CHARACTERISTIC_VALUE
    importing
      !IV_CHARC_TYPE type ATFOR
      !IT_CHANGE_VALUE type STANDARD TABLE
      !IV_LOCK type BOOLE_D default ABAP_FALSE
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT
      !ET_SUCCESS_VALUE type STANDARD TABLE .
  methods SET_CHARACTERISTIC_VALUE
    importing
      !IV_CHARC_TYPE type ATFOR
      !IT_CHANGE_VALUE type STANDARD TABLE
      !IV_LOCK type BOOLE_D default ABAP_FALSE
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT
      !ET_SUCCESS_VALUE type STANDARD TABLE .
  methods DELETE_CHARACTERISTIC_VALUE
    importing
      !IV_CHARC_TYPE type ATFOR
      !IT_CHANGE_VALUE type STANDARD TABLE
      !IV_LOCK type BOOLE_D default ABAP_FALSE
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT
      !ET_SUCCESS_VALUE type STANDARD TABLE .
  methods CALCULATE_VALUATION_EXTENSION
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods LOCK_CLASS_TYPE
    importing
      !IT_CLASSTYPE type LTT_CLASSTYPE
    returning
      value(RO_CLF_API_RESULT) type ref to IF_NGC_CLF_API_RESULT .