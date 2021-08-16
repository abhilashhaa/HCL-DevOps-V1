class CL_NGC_CORE_CHR_UTIL_CHCKTABLE definition
  public
  create private .

public section.

  interfaces IF_NGC_CORE_CHR_UTIL_CHCKTABLE .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to CL_NGC_CORE_CHR_UTIL_CHCKTABLE .