private section.

  types:
    ltt_cuobj_range TYPE RANGE OF cuobj .

  data MV_INCONINOB_NAME type VIEWNAME .
  constants GC_INCONINOB_NAME type VIEWNAME value 'ZIC_INCONINOB' ##NO_TEXT.
  data MV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME .
  data MV_CLIENT type SYMANDT .
  data:
    MT_LOCKED_INOB type standard table of INOB .

  methods LOCK_ENTRIES
    importing
      !ITR_CUOBJ type LTT_CUOBJ_RANGE
    returning
      value(RV_LOCK_ERROR) type BOOLE_D .
  methods UNLOCK_ENTRIES .
  methods CREATE_VIEWS
    returning
      value(RV_SUCCESS) type BOOLE_D .
  methods DELETE_VIEWS
    importing
      !IV_LOG_ERROR type BOOLE_D default ABAP_TRUE .