private section.

  class-data GO_DRF_EWM_CLS type ref to CL_NGC_DRF_EWM_CLS .
  data MS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  data MO_NGC_DRF_UTIL type ref to IF_NGC_DRF_UTIL .
  constants GC_CLS_KEY type STRING value 'NGCT_DRF_CLSMAS_OBJECT_KEY' ##NO_TEXT.
  data MT_RELEVANT_OBJECTS type NGCT_DRF_CLSMAS_OBJECT_KEY .
  data MO_CIF_FUNCTIONS type ref to LIF_CIF_FUNCTIONS .
  data MO_EWM_UTIL type ref to IF_NGC_DRF_EWM_UTIL .
  data MV_PROCESSED_RELOBJ_NUM type I value 0 ##NO_TEXT.
  data MO_FILTER type ref to IF_DRF_FILTER .

  methods SEND_CIF_CLASS
    importing
      !IT_RELEVANT_OBJECTS type NGCT_DRF_CLSMAS_OBJECT_KEY
    changing
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL .
  methods SEND_CHARACTERISTICS
    importing
      !IT_KSML type TT_KSML
    changing
      !CS_CTRLPARAMS type CIFCTRLPAR
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL .
  methods GET_FILTER
    returning
      value(RO_FILTER) type ref to IF_DRF_FILTER .