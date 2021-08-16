protected section.

  types:
    BEGIN OF ts_clf_status.
        INCLUDE TYPE tclc.
    TYPES: clfnstatusdescription TYPE eintext.
    TYPES: END OF ts_clf_status .
  types:
    tt_clf_status TYPE SORTED TABLE OF ts_clf_status WITH UNIQUE KEY klart statu .

  class-data GO_INSTANCE type ref to CL_NGC_CLF_STATUS .
  data MO_CLF_PERSISTENCY type ref to IF_NGC_CORE_CLF_PERSISTENCY .
  data MO_DOMAIN_VALUE_VALIDATOR type ref to IF_NGC_CLF_VALIDATOR .
  data MO_VALUE_USED_LEAF_VALIDATOR type ref to IF_NGC_CLF_VALIDATOR .

  methods CONSTRUCTOR .