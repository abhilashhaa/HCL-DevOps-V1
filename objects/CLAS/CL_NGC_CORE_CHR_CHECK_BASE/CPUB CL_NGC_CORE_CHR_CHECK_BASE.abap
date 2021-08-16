class CL_NGC_CORE_CHR_CHECK_BASE definition
  public
  abstract
  create public .

public section.

  interfaces IF_NGC_CORE_CHR_VALUE_CHECK .

  methods CONSTRUCTOR
    importing
      !IV_DATA_TYPE type ATFOR .