interface IF_NGC_CHD_UTIL
  public .


  constants GC_CLF_OBJECT_CLASS type CDOBJECTCL value 'CLASSIFY' ##NO_TEXT.

  methods GET_CLF_OBJECT
    importing
      !IT_OBJECT_ID type CDOBJECTV_RANGE_TAB
      !IV_OBJECT_TABLE type TABELLE
    changing
      !CT_CLF_OBJECT type IF_CD_PROCESSING=>TT_OBJECT .
endinterface.