class CL_NGC_API definition
  public
  create public .

public section.

  interfaces IF_NGC_CHR_API_READ .
  interfaces IF_NGC_CLF_API_WRITE .
  interfaces IF_NGC_CLS_API_READ .
  interfaces IF_NGC_CLF_API_READ .
  interfaces IF_NGC_API .

  methods CONSTRUCTOR
    importing
      !IO_API_FACTORY type ref to CL_NGC_API_FACTORY
      !IO_CLF_PERSISTENCY type ref to IF_NGC_CORE_CLF_PERSISTENCY
      !IO_CLS_PERSISTENCY type ref to IF_NGC_CORE_CLS_PERSISTENCY
      !IO_CLF_VALIDATION_MGR type ref to CL_NGC_CLF_VALIDATION_MGR
      !IO_CHR_PERSISTENCY type ref to IF_NGC_CORE_CHR_PERSISTENCY .
  class-methods CLASS_CONSTRUCTOR .