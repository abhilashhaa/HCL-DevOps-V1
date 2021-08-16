class CL_NGC_CORE_CLF_DB_UPDATE definition
  public
  final
  create private .

public section.

  interfaces IF_NGC_CORE_CLF_DB_UPDATE .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to IF_NGC_CORE_CLF_DB_UPDATE .