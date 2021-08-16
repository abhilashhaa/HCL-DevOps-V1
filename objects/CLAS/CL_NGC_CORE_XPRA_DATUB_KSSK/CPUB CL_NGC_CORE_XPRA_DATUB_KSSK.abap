class CL_NGC_CORE_XPRA_DATUB_KSSK definition
  public
  inheriting from CL_NGC_CORE_DATA_CONV
  final
  create public .

public section.

  class-methods BEFORE_CONVERSION
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLIENT type MANDT
      !IV_REWORK type BOOLE_D
    returning
      value(RV_EXIT) type BOOLE_D .
  class-methods AFTER_CONVERSION .
  methods UPDATE_VCH_UPD_STATUS
    importing
      !IV_SET type BOOLE_D .

  methods CONVERT_CLIENT
    redefinition .
  methods PROCESS_PACKAGE
    redefinition .