class CL_NGC_CORE_CONV_PFW_UTIL definition
  public
  final
  create private .

public section.

  interfaces IF_NGC_CORE_CONV_PFW_UTIL .
  interfaces IF_SERIALIZABLE_OBJECT .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to IF_NGC_CORE_CONV_PFW_UTIL .