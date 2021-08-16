class CL_NGC_CLF_STATUS definition
  public
  final
  create protected .

public section.

  interfaces IF_NGC_CLF_STATUS .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to IF_NGC_CLF_STATUS .