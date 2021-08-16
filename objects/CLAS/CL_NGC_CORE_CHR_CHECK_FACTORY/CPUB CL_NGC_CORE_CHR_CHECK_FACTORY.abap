class CL_NGC_CORE_CHR_CHECK_FACTORY definition
  public
  create public

  global friends TH_NGC_CHR_CHECK_FACTORY_INJ .

public section.

  class-methods GET_INSTANCE
    importing
      !IV_CHARC_DATA_TYPE type ATFOR
    returning
      value(RO_INSTANCE) type ref to IF_NGC_CORE_CHR_VALUE_CHECK
    raising
      CX_NGC_CORE_CHR_EXCEPTION .