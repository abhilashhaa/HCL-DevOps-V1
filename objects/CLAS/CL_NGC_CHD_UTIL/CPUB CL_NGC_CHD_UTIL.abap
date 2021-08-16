class CL_NGC_CHD_UTIL definition
  public
  final
  create public .

public section.

  interfaces IF_NGC_CHD_UTIL .

  aliases GC_CLF_OBJECT_CLASS
    for IF_NGC_CHD_UTIL~GC_CLF_OBJECT_CLASS .
  aliases GET_CLF_OBJECT
    for IF_NGC_CHD_UTIL~GET_CLF_OBJECT .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to IF_NGC_CHD_UTIL .