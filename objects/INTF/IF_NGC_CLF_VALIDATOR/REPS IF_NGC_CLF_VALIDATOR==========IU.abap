interface IF_NGC_CLF_VALIDATOR
  public .


  methods VALIDATE
    importing
      !IV_CLASSTYPE type KLASSENART
      !IO_DATA_PROVIDER type ref to IF_NGC_CLF_VALIDATION_DP
      !IO_CLASSIFICATION type ref to IF_NGC_CLASSIFICATION
    returning
      value(RO_CLF_API_RESULT) type ref to IF_NGC_CLF_API_RESULT .
endinterface.