class CL_NGC_CLF_UTIL_CONV definition
  public
  final
  create public .

public section.

  class-methods CONV_DB_TO_NGC
    importing
      !IO_NGC_API type ref to IF_NGC_API optional
      !IO_NGC_CORE_CLF_PERSISTENCY type ref to IF_NGC_CORE_CLF_PERSISTENCY optional
      !IO_NGC_CORE_CLS_UTIL_INTERSECT type ref to IF_NGC_CORE_CLS_UTIL_INTERSECT optional
      !IV_KEY_DATE type BAPI_KEYDATE default SY-DATUM
      !IT_INOB type TT_INOB optional
      !IT_KSSK_INSERT type TT_KSSK optional
      !IT_KSSK_DELETE type TT_KSSK optional
      !IT_AUSP_INSERT type TT_AUSP optional
      !IT_AUSP_DELETE type TT_AUSP optional
    exporting
      !ET_CLASSIFICATION type NGCT_CLASSIFICATION_CHANGES
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .