class CL_NGC_BIL_FACTORY definition
  public
  final
  create private

  global friends TH_NGC_BIL_FACTORY_INJT .

public section.

  class-methods GET_CLASSIFICATION
    returning
      value(RO_CLASSIFICATION) type ref to IF_NGC_BIL_CLF .
  class-methods GET_CLASSIFICATION_EML
    returning
      value(RO_CLASSIFICATION_EML) type ref to IF_NGC_BIL_CLF_EML .
  class-methods GET_CLASSIFICATION_UTIL
    returning
      value(RO_CLASSIFICATION_UTIL) type ref to IF_NGC_BIL_CLF_UTIL .
  class-methods GET_CHARACTERISTIC
    returning
      value(RO_CHARACTERISTIC) type ref to IF_NGC_BIL_CHR .
  class-methods GET_CLASS
    returning
      value(RO_CLASS) type ref to IF_NGC_BIL_CLS .