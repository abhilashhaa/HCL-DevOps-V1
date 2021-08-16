interface IF_NGC_CHARACTERISTIC
  public .


  methods GET_HEADER
    returning
      value(RS_CHARACTERISTIC_HEADER) type NGCS_CHARACTERISTIC .
  methods GET_DOMAIN_VALUES
    exporting
      !EO_CHR_API_RESULT type ref to IF_NGC_CHR_API_RESULT
    returning
      value(ET_DOMAIN_VALUE) type NGCT_CHARACTERISTIC_VALUE .
  methods GET_CHARACTERISTIC_REF
    returning
      value(RT_CHARACTERISTIC_REF) type NGCT_CHARACTERISTIC_REF .
endinterface.