interface IF_NGC_CLASS
  public .


  methods GET_HEADER
    returning
      value(RS_CLASS_HEADER) type NGCS_CLASS .
  methods GET_CHARACTERISTICS
    exporting
      value(ET_CHARACTERISTIC) type NGCT_CHARACTERISTIC_OBJECT
      value(ET_CHARACTERISTIC_ORG_AREA) type NGCT_CLASSIFICATION_ORG_AREA
      !EO_CLS_API_RESULT type ref to IF_NGC_CLS_API_RESULT .
endinterface.