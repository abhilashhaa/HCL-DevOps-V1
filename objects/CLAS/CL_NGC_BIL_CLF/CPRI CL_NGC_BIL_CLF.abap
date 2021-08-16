private section.

  types:
    BEGIN OF lty_s_classification_key,
        clfnobjectid    TYPE cuobn,
        clfnobjecttable TYPE tabelle,
        cid             TYPE string,
      END OF lty_s_classification_key .
  types:
    lty_t_classification_key TYPE STANDARD TABLE OF lty_s_classification_key WITH EMPTY KEY .
  types:
    BEGIN OF lty_s_objectclass,
        clfnobjectid    TYPE cuobn,
        clfnobjecttable TYPE tabelle,
        classinternalid TYPE clint,
        classtype       TYPE klassenart,
        cid             TYPE string,
      END OF lty_s_objectclass .
  types:
    lty_t_objectclass TYPE STANDARD TABLE OF lty_s_objectclass WITH EMPTY KEY .
  types:
    BEGIN OF lty_s_objectcharc,
        clfnobjectid    TYPE cuobn,
        clfnobjecttable TYPE tabelle,
        charcinternalid TYPE clint,
        classtype       TYPE klassenart,
        cid             TYPE string,
      END OF lty_s_objectcharc .
  types:
    lty_t_objectcharc TYPE STANDARD TABLE OF lty_s_objectcharc WITH EMPTY KEY .
  types:
    BEGIN OF lty_s_objectcharcval,
        clfnobjectid             TYPE cuobn,
        clfnobjecttable          TYPE tabelle,
        charcinternalid          TYPE clint,
        charcvaluepositionnumber TYPE atzhl,
        classtype                TYPE klassenart,
        cid                      TYPE string,
      END OF lty_s_objectcharcval .
  types:
    lty_t_objectcharcval TYPE STANDARD TABLE OF lty_s_objectcharcval WITH EMPTY KEY .

  data MO_NGC_API type ref to IF_NGC_API .
  data MO_SY_MSG_CONVERT type ref to IF_RAP_PLMI_SY_MSG_CONVERT .
  data MT_CLASSIFICATION type NGCT_CLASSIFICATION_OBJECT .
  constants GC_ERROR_CODES type STRING value 'EAX' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IO_NGC_API type ref to IF_NGC_API
      !IO_SY_MSG_CONVERT type ref to IF_RAP_PLMI_SY_MSG_CONVERT .
  methods GET_CLASSIFICATIONS
    importing
      !IT_CLASSIFICATION_KEY type LTY_T_CLASSIFICATION_KEY
    exporting
      !ET_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods ADD_EXCEPTION_TO_OBJECT_MSG
    importing
      !IS_CLFNOBJECT type LTY_S_CLASSIFICATION_KEY optional
      !IO_EXCEPTION type ref to CX_ROOT
      !IV_CAUSE type IF_ABAP_BEHV=>T_FAIL_CAUSE default IF_ABAP_BEHV=>CAUSE-UNSPECIFIC
    changing
      !CT_FAILED type IF_NGC_BIL_CLF~TS_FAILED optional
      !CT_REPORTED type IF_NGC_BIL_CLF~TS_REPORTED optional .
  methods ADD_OBJECT_MSG
    importing
      !IT_CLFNOBJECT type LTY_T_CLASSIFICATION_KEY
      !IO_NGC_API_RESULT type ref to IF_NGC_CLF_API_RESULT optional
      !IV_CAUSE type IF_ABAP_BEHV=>T_FAIL_CAUSE default IF_ABAP_BEHV=>CAUSE-UNSPECIFIC
    changing
      !CT_REPORTED type IF_NGC_BIL_CLF~TS_REPORTED optional
      !CT_FAILED type IF_NGC_BIL_CLF~TS_FAILED optional .
  methods ADD_OBJECT_CHARC_MSG
    importing
      !IT_CLFNOBJECTCHARC type LTY_T_OBJECTCHARC
      !IO_NGC_API_RESULT type ref to IF_NGC_CLF_API_RESULT optional
      !IV_CAUSE type IF_ABAP_BEHV=>T_FAIL_CAUSE default IF_ABAP_BEHV=>CAUSE-UNSPECIFIC
    changing
      !CT_REPORTED type IF_NGC_BIL_CLF~TS_REPORTED optional
      !CT_FAILED type IF_NGC_BIL_CLF~TS_FAILED optional .
  methods ADD_OBJECT_CHARC_VAL_MSG
    importing
      !IT_CLFNOBJECTCHARCVAL type LTY_T_OBJECTCHARCVAL
      !IO_NGC_API_RESULT type ref to IF_NGC_CLF_API_RESULT optional
      !IV_CAUSE type IF_ABAP_BEHV=>T_FAIL_CAUSE default IF_ABAP_BEHV=>CAUSE-UNSPECIFIC
    changing
      !CT_REPORTED type IF_NGC_BIL_CLF~TS_REPORTED optional
      !CT_FAILED type IF_NGC_BIL_CLF~TS_FAILED optional .
  methods ADD_OBJECT_CLASS_MSG
    importing
      !IT_CLFNOBJECTCLASS type LTY_T_OBJECTCLASS
      !IO_NGC_API_RESULT type ref to IF_NGC_CLF_API_RESULT optional
      !IV_CAUSE type IF_ABAP_BEHV=>T_FAIL_CAUSE default IF_ABAP_BEHV=>CAUSE-UNSPECIFIC
    changing
      !CT_REPORTED type IF_NGC_BIL_CLF~TS_REPORTED optional
      !CT_FAILED type IF_NGC_BIL_CLF~TS_FAILED optional .
  methods CHECK_OBJECT_CHARC_VAL
    importing
      !IV_DATA_TYPE type ATFOR
      !IS_VALUE type I_CLFNOBJECTCHARCVALUETP
    returning
      value(RV_VALID) type ABAP_BOOL .
  methods GET_CLASS_FROM_OBJCLASS
    importing
      !IT_OBJ_OBJCLASS type IF_NGC_BIL_CLF=>TS_OBJ-CREATE_BY-_OBJECTCLASS-T_INPUT
    returning
      value(RT_OBJCLASS) type IF_NGC_BIL_CLF=>TS_OBJCLASS-CREATE-T_INPUT .
  methods GET_CHARCVAL_FROM_CHARC
    importing
      !IT_CHARC_OBJECTCHARCVAL type IF_NGC_BIL_CLF=>TS_OBJCHARC-CREATE_BY-_OBJECTCHARCVALUE-T_INPUT
    returning
      value(RT_OBJECTCHARCVAL) type IF_NGC_BIL_CLF=>TS_OBJCHARCVAL-CREATE-T_INPUT .