class CL_NGC_CLF_VALIDATION_MGR definition
  public
  create protected .

public section.

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to CL_NGC_CLF_VALIDATION_MGR .
  methods VALIDATE
    importing
      !IO_CLASSIFICATION type ref to IF_NGC_CLASSIFICATION
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .