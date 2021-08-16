private section.

  methods PREPARE_CUSTOMIZING
    raising
      CX_DATA_CONV_ERROR .
  methods MAKE_NEW_ENTRIES
    importing
      !IT_KSSK type LTT_KSSK
      !IT_AUSP type LTT_AUSP
    exporting
      !ET_KSSK_INS type LTST_KSSK
      !ET_AUSP_INS type LTST_AUSP
      !ET_INOB_INS type LTST_INOB
    raising
      CX_DATA_CONV_ERROR .
  methods BUILD_TCLA_CACHE .
  methods CREATE_VIEWS
    returning
      value(RV_SUCCESS) type BOOLE_D .
  methods DELETE_VIEWS
    importing
      !IV_LOG_ERROR type BOOLE_D default ABAP_TRUE .
  methods UPDATE_MULTOBJ
    raising
      CX_DATA_CONV_ERROR .