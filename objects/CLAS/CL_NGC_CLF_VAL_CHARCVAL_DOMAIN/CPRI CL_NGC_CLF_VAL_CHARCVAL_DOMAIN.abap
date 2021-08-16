private section.

  methods CHECK_VALUE_INCLUSION
    importing
      !IT_DOMAIN_VALUE type NGCT_CHARACTERISTIC_VALUE
      !IS_VALUATION_DATA_UPD type NGCS_VALUATION_DATA_UPD
    changing
      !CV_SUBRC type SUBRC .