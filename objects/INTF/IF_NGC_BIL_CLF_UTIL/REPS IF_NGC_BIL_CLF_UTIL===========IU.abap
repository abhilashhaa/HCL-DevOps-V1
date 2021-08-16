interface IF_NGC_BIL_CLF_UTIL
  public .


  methods SERIALIZE_DATA
    importing
      !IS_DATA type ANY
    returning
      value(RV_DATA_BINARY) type XSTRING
    raising
      CX_TRANSFORMATION_ERROR .
  methods DESERIALIZE_DATA
    importing
      !IV_TABLE type ATTAB
      !IV_DATA_BINARY type XSTRING
    exporting
      !ES_DATA type ANY
      !ER_DATA type ref to DATA
    raising
      CX_SY_CREATE_DATA_ERROR
      CX_TRANSFORMATION_ERROR .
endinterface.