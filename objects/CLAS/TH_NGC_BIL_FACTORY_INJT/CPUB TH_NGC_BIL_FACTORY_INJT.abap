class TH_NGC_BIL_FACTORY_INJT definition
  public
  final
  create private
  for testing .

public section.

  class-methods SET_CLASSIFICATION
    importing
      !IO_CLASSIFICATION type ref to IF_NGC_BIL_CLF .
  class-methods SET_CLASSIFICATION_EML
    importing
      !IO_CLASSIFICATION_EML type ref to IF_NGC_BIL_CLF_EML .
  class-methods SET_CLASSIFICATION_UTIL
    importing
      !IO_CLASSIFICATION_UTIL type ref to IF_NGC_BIL_CLF_UTIL .
  class-methods SET_CHARACTERISTIC
    importing
      !IO_CHARACTERISTIC type ref to IF_NGC_BIL_CHR .
  class-methods SET_CLASS
    importing
      !IO_CLASS type ref to IF_NGC_BIL_CLS .
  class-methods RESET .