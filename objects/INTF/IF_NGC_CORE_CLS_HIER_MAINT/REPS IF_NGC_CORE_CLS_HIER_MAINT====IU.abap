interface IF_NGC_CORE_CLS_HIER_MAINT
  public .


  methods ADD_NODE
    importing
      !IV_NODE type CLINT
      !IV_DATUV type DATUV default CL_NGC_CORE_CLS_UTIL=>GC_DATE_INITIAL
      !IV_DATUB type DATUB default CL_NGC_CORE_CLS_UTIL=>GC_DATE_INFINITE
      !IV_KLART type KLASSENART optional
      !IV_UPD_RELEV type ABAP_BOOL default ABAP_TRUE .
  methods DELETE_NODE
    importing
      !IV_NODE type CLINT
      !IV_DATUV type DATUV .
  methods UPDATE_NODE
    importing
      !IV_NODE type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB .
  methods UPDATE_RELATIONS
    importing
      !IT_RELATIONS type TT_KSSK
      !IV_ACTION type CDCHNGIND
      !IV_NEW_DATE type DATUV optional .
  methods UPDATE
    importing
      !IV_MANDT type MANDT optional .
  methods RESET .
endinterface.