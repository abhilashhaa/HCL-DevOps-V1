private section.

  methods CONVERT_CORE
    importing
      !IV_INPUTVIEW_NAME type VIEWNAME
      !IV_PROCPACK_NAME type IF_SHDB_PFW_DEF=>TV_PFW_METHODNAME
      !IV_PACKAGE_SIZE type I
    raising
      CX_SHDB_PFW_EXCEPTION
      CX_SHDB_PFW_APPL_ERROR .
  class-methods CREATE_VIEWS
    returning
      value(RV_SUCCESS) type BOOLE_D .
  class-methods DELETE_VIEWS
    importing
      !IV_LOG_ERROR type BOOLE_D default ABAP_TRUE .
  methods UPDATE_CREATOR
    changing
      !CT_CLF_HDR type TT_CLF_HDR .
  methods INCREASE_EVENT
    importing
      !IV_EVENT type I
      !IV_PARAM type STRING optional
    changing
      !CT_EVENTS type LTT_EVENT_COUNT .