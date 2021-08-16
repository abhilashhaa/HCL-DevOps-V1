interface IF_NGC_BIL_CLF_TRANSACTIONAL
  public .


  methods FINALIZE
    exporting
      !ES_FAILED type IF_NGC_BIL_CLF=>TS_FAILED_LATE
      !ES_REPORTED type IF_NGC_BIL_CLF=>TS_REPORTED_LATE .
  methods SAVE .
  methods CLEANUP .
endinterface.