interface IF_NGC_CLF_STATUS
  public .


  methods REFRESH_STATUS
    importing
      !IO_CLASSIFICATION type ref to IF_NGC_CLASSIFICATION
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods CHANGE_STATUS
    importing
      !IV_STATUS type CLSTATUS
      !IO_CLASSIFICATION type ref to IF_NGC_CLASSIFICATION
      !IV_CLASSINTERNALID type CLINT
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT
    exceptions
      INVALID_STATUS_CODE
      CHANGE_NOT_POSSIBLE .
  methods GET_CLASSTYPE_STATUS
    importing
      !IO_CLASSIFICATION type ref to IF_NGC_CLASSIFICATION
      !IV_CLASSTYPE type KLASSENART
    exporting
      !EV_RELEASED type ABAP_BOOL
      !EV_INCONSISTENT type ABAP_BOOL .
endinterface.