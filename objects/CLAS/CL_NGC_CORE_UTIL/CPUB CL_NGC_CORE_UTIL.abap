class CL_NGC_CORE_UTIL definition
  public
  create protected .

public section.

  interfaces IF_NGC_CORE_UTIL .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to CL_NGC_CORE_UTIL .