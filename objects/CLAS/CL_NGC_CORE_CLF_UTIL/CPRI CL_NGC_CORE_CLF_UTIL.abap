private section.

  types:
    BEGIN OF TS_CLF_STATUS.
  INCLUDE TYPE TCLC.
  TYPES: CLFNSTATUSDESCRIPTION TYPE EINTEXT.
  TYPES: END OF TS_CLF_STATUS .
  types:
    TT_CLF_STATUS TYPE SORTED TABLE OF TS_CLF_STATUS WITH UNIQUE KEY klart statu .

  class-data GTS_CLF_STATUS type TT_CLF_STATUS .
  class-data GO_INSTANCE type ref to IF_NGC_CORE_CLF_UTIL .

  methods LOAD_STATUSES .