interface IF_NGC_CLS_API_READ
  public .


  methods READ
    importing
      !IT_CLASS_KEY type NGCT_CLASS_KEY
    exporting
      !ET_CLASS type NGCT_CLASS_OBJECT
      !EO_CLS_API_RESULT type ref to IF_NGC_CLS_API_RESULT .
  methods READ_BY_EXT_KEY
    importing
      !IT_CLASS_KEY type NGCT_CLASS_KEY_EXT
    exporting
      !ET_CLASS type NGCT_CLASS_OBJECT
      !EO_CLS_API_RESULT type ref to IF_NGC_CLS_API_RESULT .
endinterface.