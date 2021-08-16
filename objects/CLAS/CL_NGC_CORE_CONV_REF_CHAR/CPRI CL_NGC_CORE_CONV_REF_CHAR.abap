private section.

  methods DETERMINE_IN_RANGE_LIMIT
    returning
      value(RV_RANGE_LIMIT) type I .
  methods DETERMINE_DYN_WHERE_LIMIT
    returning
      value(RV_DYN_WHERE_LIMIT) type I .
  methods CONVERT_CORE
    importing
      !IO_LOGGER type ref to IF_SHDB_PFW_LOGGER
      !IO_REFVAL_READER type ref to LCL_REFVAL_READER_GENERAL
      !IV_PACKAGE_SIZE type I
    raising
      CX_SHDB_PFW_EXCEPTION .
  methods COLLECT_VALIDITIES
    importing
      !IT_SIBLCHRS type LTT_AUSPVALIDITY
      !IV_OBTAB type TABELLE
      !IV_OBJEK type CUOBN
    changing
      !CT_REFVALS type LTT_REFVALIDITY .
  methods CLEANUP_AUSP
    importing
      !IT_AUSP type LTT_AUSP .
  methods CREATE_VIEWS
    returning
      value(RV_SUCCESS) type BOOLE_D .
  methods DELETE_VIEWS
    importing
      !IV_LOG_ERROR type BOOLE_D default ABAP_TRUE .
  methods PROCESS_BO
    importing
      !IT_ATTABS type LTT_REFBOU
    changing
      !CT_REFVALS type LTT_REFVALIDITY
      !CT_AUSP_MODIFY type LTT_AUSP
      !CT_EVENTS type LTT_EVENT_COUNT .
  methods MERGE_TIME_INTERVALS
    changing
      !CT_AUSP type LTT_AUSP .
  methods UPDATE_REDUN .
  methods BUILD_CLSTYPE_ECH_ITAB .
  methods GET_CLSTYPE_ECH
    importing
      !IV_KLART type KLASSENART
      !IV_OBTAB type TABELLE
    returning
      value(RV_AEDIEZUORD) type CLAEDIZUOR .
  methods LOCK_TABLES
    returning
      value(RV_ERROR) type BOOLE_D .
  methods UNLOCK_TABLES .