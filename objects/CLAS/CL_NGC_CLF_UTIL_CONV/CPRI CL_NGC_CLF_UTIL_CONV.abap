private section.

  class-data GT_CLASSTYPES type NGCT_CORE_CLASS_TYPE .

  class-methods BUILD_STRING
    importing
      !IS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
      !IS_CHARACTERISTIC_HEADER type NGCS_CHARACTERISTIC
      !IS_AUSP type AUSP
      !IO_NGC_CORE_CLS_UTIL_INTERSECT type ref to IF_NGC_CORE_CLS_UTIL_INTERSECT
      !IO_CLF_API_RESULT type ref to CL_NGC_CLF_API_RESULT
    exporting
      !EV_CHARCVALUE type ATWRT .
  class-methods GET_CLFNOBJECTTABLE
    importing
      !IV_CLASSTYPE type KLASSENART
    returning
      value(RV_CLFNOBJECTTABLE) type TABELLE .
  class-methods QUERY_CLASSTYPES
    importing
      !IT_KSSK_INSERT type TT_KSSK
      !IT_KSSK_DELETE type TT_KSSK
      !IT_AUSP_INSERT type TT_AUSP
      !IT_AUSP_DELETE type TT_AUSP .