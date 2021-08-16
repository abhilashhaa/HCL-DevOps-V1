private section.

  types:
    tt_atinn_range TYPE RANGE OF atinn .

  class-data GO_DRF_EWM_CLF type ref to CL_NGC_DRF_EWM_CLF .
  data MS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  constants GC_CLF_KEY type STRING value 'NGCT_DRF_CLFMAS_OBJECT_KEY' ##NO_TEXT.
  data MO_CIF_FUNCTIONS type ref to LIF_CIF_FUNCTIONS .
  data MO_DB_ACCESS type ref to LIF_DB_ACCESS .
  data MO_EWM_UTIL type ref to IF_NGC_DRF_EWM_UTIL .
  data MT_RELEVANT_OBJECTS type NGCT_DRF_CLFMAS_OBJECT_KEY .
  data MV_PROCESSED_RELOBJ_NUM type I value 0 ##NO_TEXT.
  data MO_FILTER type ref to IF_DRF_FILTER .

  methods CONSTRUCTOR
    importing
      !IS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  methods SEND_CIF_CLASSIFICATION
    importing
      !IT_RELEVANT_OBJECTS type NGCT_DRF_CLFMAS_OBJECT_KEY
    changing
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL   ##NEEDED
    raising
      CX_DRF_PROCESS_MESSAGES .
  methods GET_FILTER
    returning
      value(RO_FILTER) type ref to IF_DRF_FILTER .