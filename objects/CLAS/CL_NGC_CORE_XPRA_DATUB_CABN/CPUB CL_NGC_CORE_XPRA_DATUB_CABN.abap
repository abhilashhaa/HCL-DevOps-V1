class CL_NGC_CORE_XPRA_DATUB_CABN definition
  public
  inheriting from CL_NGC_CORE_DATA_CONV
  final
  create public .

public section.

  class-methods BEFORE_CONVERSION
    importing
      !IV_CLIENT type MANDT
      !IV_REWORK type BOOLE_D
    returning
      value(RV_EXIT) type BOOLE_D .
  class-methods AFTER_CONVERSION .

  methods CONVERT_CLIENT
    redefinition .
  methods PROCESS_PACKAGE
    redefinition .