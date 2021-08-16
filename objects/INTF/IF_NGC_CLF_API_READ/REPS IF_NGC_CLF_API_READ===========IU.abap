interface IF_NGC_CLF_API_READ
  public .


  methods READ
    importing
      !IT_CLASSIFICATION_KEY type NGCT_CLASSIFICATION_KEY
    exporting
      !ET_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
endinterface.