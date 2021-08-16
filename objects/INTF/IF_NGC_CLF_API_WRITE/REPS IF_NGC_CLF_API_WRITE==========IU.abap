interface IF_NGC_CLF_API_WRITE
  public .


  methods UPDATE
    importing
      !IT_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods VALIDATE
    importing
      !IT_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods SAVE .
  methods LOCK
    importing
      !IT_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods LOCK_ALL
    importing
      !IT_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
endinterface.