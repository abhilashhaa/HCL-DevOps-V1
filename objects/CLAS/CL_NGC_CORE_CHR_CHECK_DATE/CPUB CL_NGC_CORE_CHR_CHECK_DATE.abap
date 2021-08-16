class CL_NGC_CORE_CHR_CHECK_DATE definition
  public
  inheriting from CL_NGC_CORE_CHR_CHECK_BASE
  final
  create private .

public section.

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to IF_NGC_CORE_CHR_VALUE_CHECK .

  methods IF_NGC_CORE_CHR_VALUE_CHECK~CHECK_VALUE
    redefinition .