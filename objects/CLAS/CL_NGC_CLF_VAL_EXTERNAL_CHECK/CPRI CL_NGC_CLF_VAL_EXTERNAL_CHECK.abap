private section.

  methods VALIDATE_VALUE
    importing
      !IS_CHARACTERISTIC type NGCS_CHARACTERISTIC
      !IV_CHARCVALUE type ATWRT
      !IV_CLASSTYPE type KLASSENART
    exporting
      value(EV_NEW_CHARCVALUE) type ATWRT
    exceptions
      VALUE_NOT_FOUND
      FUNCTION_NOT_FOUND .
  methods CHECK_IN_FUNCTION_MODULE
    importing
      !IV_FUNCTION_NAME type ATPRF
      !IV_CHARACTERISTIC type ATNAM
      !IV_CHARCINTERNALID type ATINN
      !IV_CHARCVALUE type ATWRT
    exporting
      value(EV_NEW_CHARCVALUE) type ATWRT
    exceptions
      VALUE_NOT_FOUND
      FUNCTION_NOT_FOUND .
  methods CHECK_IN_CHECK_TABLE
    importing
      !IV_CHARCVALUE type ATWRT
      !IV_CHECK_TABLE_NAME type ATPRT
      !IS_CHARACTERISTIC type NGCS_CHARACTERISTIC
      !IV_CLASSTYPE type KLASSENART
    exporting
      !EV_NEW_CHARCVALUE type ATWRT
    exceptions
      VALUE_NOT_FOUND
      TABLE_NOT_FOUND .
  methods CHECK_CATALOG_VALUE
    importing
      !IV_PLANT type WERKS_D
      !IV_CATALOG type QKATART_CL
      !IV_SELECTION_SET type QAUSWAHLMG_CL
      !IV_CHARCVALUE type ATWRT
      !IV_LANGUAGE like SY-LANGU default SY-LANGU
    exporting
      !EV_NEW_CHARCVALUE type ATWRT
    exceptions
      VALUE_NOT_FOUND .
  methods CONVERT_INTERNAL_TO_EXTERNAL
    importing
      !IV_CLASS_TYPE type KLASSENART
      !IV_ASSIGNED_VALUE type ATWRT
      !IS_CHARACTERISTIC type NGCS_CHARACTERISTIC
      !IV_CONVEXIT type CONVEXIT
    exporting
      !EV_NEW_VALUE type ATWRT .