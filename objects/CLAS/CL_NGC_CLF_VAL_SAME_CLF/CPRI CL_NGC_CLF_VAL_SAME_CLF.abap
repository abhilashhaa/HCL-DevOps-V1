private section.
  types:
    BEGIN OF lty_s_clfnobjectclass .
      INCLUDE TYPE: i_clfnobjectclassforkeydate AS objectclass.
      TYPES: class  TYPE i_clfnclassforkeydate-class.
  TYPES: END OF lty_s_clfnobjectclass .

  types:
    lty_t_clfnobjectclass TYPE TABLE OF lty_s_clfnobjectclass WITH DEFAULT KEY .
  types:
    BEGIN OF lty_s_objecttype.
        INCLUDE TYPE tclo.
    TYPES: redun      TYPE redundanz,
           aediezuord TYPE claedizuor,
           zaehl      TYPE clsortpos.
    TYPES: END OF lty_s_objecttype .
  types:
    lty_t_objecttype TYPE TABLE OF lty_s_objecttype.

  methods GET_OBJECTS_WITH_SAME_CLF
    importing
      !IT_VALUATION_DATA type NGCT_VALUATION_DATA
      !IO_CLASS type ref to IF_NGC_CLASS
      !IS_CLASSIFICATION type NGCS_CLASSIFICATION_KEY
    returning
      value(RT_SAME_OBJECTS) type lty_t_clfnobjectclass .
  methods REMOVE_SURROUNDING_QUOTES
    importing
      !IV_ATWRT type ATWRT
    returning
      value(RV_ATWRT) type ATWRT .
  methods CHECK_SAME_VALUATION
    importing
      !IV_MULTIPLE_TABLES_ALLOWED type ABAP_BOOL
      !IT_VALUATION type NGCT_VALUATION_DATA
      !IT_CHARACTERISTICS type NGCT_CHARACTERISTIC_OBJECT
      !IV_KEYDATE type DATUV
    changing
      !CT_OBJECTS type lty_t_clfnobjectclass .
  methods GET_VALUATION_FOR_CLASS
    importing
      !IO_ASSIGNED_CLASS type ref to IF_NGC_CLASS
      !IT_VALUATION_DATA type NGCT_VALUATION_DATA
    returning
      value(RT_VALUATION_DATA) type NGCT_VALUATION_DATA .
  methods GET_EPSILON
    importing
      !IV_NUMVALUE type ATFLV
    returning
      value(RV_EPSILON) type F .