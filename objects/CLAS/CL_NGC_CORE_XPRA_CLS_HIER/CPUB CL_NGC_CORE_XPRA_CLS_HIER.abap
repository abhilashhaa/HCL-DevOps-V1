class CL_NGC_CORE_XPRA_CLS_HIER definition
  public
  inheriting from CL_NGC_CORE_DATA_CONV
  final
  create public .

public section.

  class-methods BEFORE_CONVERSION
    returning
      value(RV_EXIT) type BOOLE_D .
  class-methods AFTER_CONVERSION .

  methods CONVERT_CLIENT
    redefinition .
  methods PROCESS_PACKAGE
    redefinition .