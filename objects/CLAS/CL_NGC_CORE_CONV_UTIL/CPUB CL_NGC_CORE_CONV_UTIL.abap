class CL_NGC_CORE_CONV_UTIL definition
  public
  final
  create private .

public section.

  interfaces IF_NGC_CORE_CONV_UTIL .
  interfaces IF_SERIALIZABLE_OBJECT .

  class-data GV_NODELEAF_VIEW_SOURCE type STRING read-only .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to IF_NGC_CORE_CONV_UTIL .
  class-methods CLASS_CONSTRUCTOR .