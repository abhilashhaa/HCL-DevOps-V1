private section.

  class-data GO_INSTANCE type ref to IF_NGC_DRF_EWM_UTIL .
  data MO_DB_ACCESS type ref to LIF_DB_ACCESS .
  data MV_REPLICATION_MODE type DRF_DLMOD value IF_DRF_CONST=>MODE_DIRECTLY ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IV_REPLICATION_MODE type DRF_DLMOD default IF_DRF_CONST=>MODE_DIRECTLY .