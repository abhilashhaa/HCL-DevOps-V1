interface IF_NGC_CORE_CLF_UTIL
  public .


  methods GET_CLASS_HIERARCHY
    importing
      !IV_CLASSTYPE type KLASSENART
      !IV_CLASS type KLASSE_D
    exporting
      !ET_GHCL type TT_GHCL .
  methods GET_CLF_STATUSES
    importing
      !IV_CLASSTYPE type KLASSENART
    returning
      value(RT_CLASSIFICATION_STATUSES) type NGCT_CORE_CLASSIFICATION_STAT .
  methods GET_CLF_STATUS_DESCRIPTION
    importing
      !IV_CLASSTYPE type KLASSENART
      !IV_CLFNSTATUS type CLSTATUS
    returning
      value(RV_CLFNSTATUSDESCRIPTION) type EINTEXT .
  methods GET_NEXT_CUOBJ_FROM_NR
    returning
      value(RV_CUOBJ) type CUOBJ .
endinterface.