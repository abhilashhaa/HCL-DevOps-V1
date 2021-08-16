protected section.

  data MT_CLHIER_IDX_INSERT type NGCT_CLHIER_IDX .
  data MT_CLHIER_IDX_UPDATE type NGCT_CLHIER_IDX .
  data MT_CLHIER_IDX_DELETE type NGCT_CLHIER_IDX .
  data MT_RELEVANT_RELATIONS type NGCT_CLHIER_IDX_SORTED .
  data MT_DIRECT_RELATIONS type NGCT_CLHIER_IDX .
  data MO_DB_ACCESS type ref to IF_NGC_CORE_CLS_HIER_DBACCESS .

  methods ADD_RELATION
    importing
      !IV_ANCESTOR type CLINT
      !IV_NODE type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB default CL_NGC_CORE_CLS_UTIL=>GC_DATE_INFINITE
      !IV_KLART type KLASSENART optional
      !IV_AENNR type AENNR optional .
  methods DELETE_RELATION
    importing
      !IV_ANCESTOR type CLINT
      !IV_NODE type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
      !IV_KLART type KLASSENART
      !IV_AENNR type AENNR .
  methods UPDATE_RELATION
    importing
      !IV_ANCESTOR type CLINT
      !IV_NODE type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
      !IV_KLART type KLASSENART
      !IV_AENNR type AENNR
      !IV_NEW_DATE type DATS
      !IV_DELETE type LKENZ .
  methods GET_ANCESTOR_RELATIONS
    importing
      !IV_NODE type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
    returning
      value(RT_ANCESTOR_RELATIONS) type NGCT_CLHIER_IDX .
  methods GET_DESCENDANT_RELATIONS
    importing
      !IV_NODE type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
    returning
      value(RT_DESCENDANT_RELATIONS) type NGCT_CLHIER_IDX .
  methods GET_RELATION_BY_KEY
    importing
      !IV_NODE type CLINT
      !IV_ANCESTOR type CLINT
      !IV_DATUV type DATS
    returning
      value(RS_RELATION) type NGC_CLHIER_IDX .
  methods GET_VALID_RELATION
    importing
      !IV_NODE type CLINT
      !IV_ANCESTOR type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
    returning
      value(RS_RELATION) type NGC_CLHIER_IDX .
  methods GET_VALID_RELATIONS
    importing
      !IV_NODE type CLINT
      !IV_ANCESTOR type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
    returning
      value(RT_RELATIONS) type NGCT_CLHIER_IDX .
  methods GET_RELATIONS
    importing
      !IT_ANCESTORS type NGCT_CLHIER_IDX
      !IT_DESCENDANTS type NGCT_CLHIER_IDX
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
      !IV_AENNR type AENNR
    exporting
      !ET_INSERTABLE type NGCT_CLHIER_IDX
      !ET_UPDATABLE type NGCT_CLHIER_IDX
      !ET_REMOVABLE type NGCT_CLHIER_IDX .
  methods GET_DIRECT_PARENT_RELATIONS
    importing
      !IV_NODE type CLINT
    returning
      value(RT_DIRECT_PARENT_RELATIONS) type NGCT_CLHIER_IDX .
  methods GET_ACTIVE_RELATIONS
    importing
      !IV_ROOT_NODE type CLINT
      !IV_DATUV type DATUV default '00000000'
      !IV_DATUB type DATUB default '99991231'
      !IV_AENNR type AENNR optional
    changing
      !CT_RELATIONS type NGCT_CLHIER_IDX .
  methods UPDATE_EXISTING_RELATIONS
    importing
      !IT_RELATIONS_FOR_NODE type NGCT_CLHIER_IDX
      !IV_ROOT_NODE type CLINT .
  methods UPDATE_RECORD
    importing
      !IV_NODE type CLINT
      !IV_ANCESTOR type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
      !IV_KLART type KLASSENART optional
      !IV_AENNR type AENNR .
  methods DELETE_RECORD
    importing
      !IV_NODE type CLINT
      !IV_ANCESTOR type CLINT
      !IV_DATUV type DATUV .
  methods INSERT_RECORD
    importing
      !IV_NODE type CLINT
      !IV_ANCESTOR type CLINT
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
      !IV_KLART type KLASSENART
      !IV_AENNR type AENNR
      !IV_UPD_RELEV type ABAP_BOOL default ABAP_TRUE .
  methods PRECHECK_DATES
    importing
      !IV_DATUV type DATUV
      !IV_DATUB type DATUB
      !IV_TABLE_NAME type CHAR30 .
  methods SORT_RELATIONS .