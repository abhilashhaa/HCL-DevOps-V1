interface IF_NGC_CORE_CLS_HIER_DBACCESS
  public .


  methods GET_ANCESTORS
    importing
      !IT_RELATIONS type TT_KSSK
    returning
      value(RT_ANCESTORS) type NGCT_CLHIER_IDX .
  methods GET_DESCENDANTS
    importing
      !IT_RELATIONS type TT_KSSK
    returning
      value(RT_DESCENDANTS) type NGCT_CLHIER_IDX .
  methods GET_RELEVANT_RELATIONS
    importing
      !IT_RELATIONS type TT_KSSK
      !IT_DESCENDANTS type NGCT_CLHIER_IDX
      !IT_ANCESTORS type NGCT_CLHIER_IDX
    returning
      value(RT_RELATIONS) type NGCT_CLHIER_IDX .
  methods GET_DIRECT_RELATIONS
    importing
      !IT_RELATIONS type NGCT_CLHIER_IDX
    returning
      value(RT_RELATIONS) type NGCT_CLHIER_IDX .
  methods UPDATE
    importing
      !IT_INSERT type NGCT_CLHIER_IDX
      !IT_DELETE type NGCT_CLHIER_IDX
      !IT_UPDATE type NGCT_CLHIER_IDX .
endinterface.