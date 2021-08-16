private section.

  data MO_NGC_DRF_EWM_UTIL type ref to IF_NGC_DRF_EWM_UTIL .

  methods DROP_OBJECTS_IF_NO_BATCH_REPLI
    importing
      !IV_DLMOD type DRF_DLMOD
      !IV_BUSINESS_SYSTEM type MDG_BUSINESS_SYSTEM
    changing
      !CT_OBJECT type IF_NGC_DRF_EWM_UTIL=>TY_T_CLF_BATCH_KEY .