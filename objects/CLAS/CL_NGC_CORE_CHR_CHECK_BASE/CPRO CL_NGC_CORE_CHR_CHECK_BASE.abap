protected section.

  data MO_CLS_UTIL_INTERSECT type ref to IF_NGC_CORE_CLS_UTIL_INTERSECT .
  data MV_DATA_TYPE type ATFOR .

  methods CHECK_LENGTH
    importing
      !IV_VALUE type ATFLV
      !IS_CHARC_HEADER type NGCS_CORE_CHARC
    exporting
      !ET_MESSAGE type NGCT_CORE_CHARC_MSG
    raising
      CX_NGC_CORE_CHR_EXCEPTION .
  methods BUILD_STRING
    importing
      !IS_CHARC_VALUE type NGCS_CORE_CHARC_VALUE
      !IS_CHARC_HEADER type NGCS_CORE_CHARC
    exporting
      !EV_CHARC_VALUE type ATWRT
      !ET_MESSAGE type NGCT_CORE_CHARC_MSG .