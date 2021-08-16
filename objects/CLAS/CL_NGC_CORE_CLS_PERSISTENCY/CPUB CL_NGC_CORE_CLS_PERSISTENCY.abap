class CL_NGC_CORE_CLS_PERSISTENCY definition
  public
  create public

  global friends TC_NGC_CORE_CLS_PERSISTENCY .

public section.

  interfaces IF_NGC_CORE_CLS_PERSISTENCY .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to CL_NGC_CORE_CLS_PERSISTENCY .
  methods CONSTRUCTOR
    importing
      !IO_UTIL_INTERSECT type ref to IF_NGC_CORE_CLS_UTIL_INTERSECT
      !IO_CHR_PERSISTENCY type ref to IF_NGC_CORE_CHR_PERSISTENCY .