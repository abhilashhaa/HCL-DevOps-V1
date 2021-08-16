private section.

  class-data GO_DRF_EWM_CHR type ref to CL_NGC_DRF_EWM_CHR .
  data MS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  data MO_NGC_DRF_UTIL type ref to IF_NGC_DRF_UTIL .
  constants GC_CHR_KEY type STRING value 'NGCT_DRF_CHRMAS_OBJECT_KEY' ##NO_TEXT.
  data MO_DB_ACCESS type ref to LIF_DB_ACCESS .
  data MO_EWM_UTIL type ref to IF_NGC_DRF_EWM_UTIL .
  data MT_RELEVANT_OBJECTS type NGCT_DRF_CHRMAS_OBJECT_KEY .
  data MV_PROCESSED_RELOBJ_NUM type I value 0 ##NO_TEXT.
  data MO_FILTER type ref to IF_DRF_FILTER .

  methods CONSTRUCTOR
    importing
      !IS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  methods GET_FILTER
    returning
      value(RO_FILTER) type ref to IF_DRF_FILTER .