class CL_NGC_CLF_UTIL_VALUATION_EXT definition
  public
  final
  create public .

public section.

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to CL_NGC_CLF_UTIL_VALUATION_EXT .
  methods CALCULATE_VALUATION_EXTENSION
    importing
      !IS_CHARACTERISTIC_HEADER type NGCS_CHARACTERISTIC
    changing
      !CS_VALUATION_DATA type NGCS_VALUATION_DATA .
  class-methods CONVERT_FLTP_TO_DATE
    importing
      !IV_FLTP_VALUE type F
    returning
      value(RV_DATE) type AUSPEXT_DATE_FROM
    exceptions
      CONVERSION_ERROR .
  class-methods CONVERT_FLTP_TO_TIME
    importing
      !IV_FLTP_VALUE type F
    returning
      value(RV_TIME) type AUSPEXT_TIME_FROM
    exceptions
      CONVERSION_ERROR .