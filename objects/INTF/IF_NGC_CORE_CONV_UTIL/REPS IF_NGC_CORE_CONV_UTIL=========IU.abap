interface IF_NGC_CORE_CONV_UTIL
  public .


  types:
    tt_object_area TYPE STANDARD TABLE OF cltable WITH EMPTY KEY .

  methods IS_AUTHORIZED
    returning
      value(RV_AUTHORIZED) type BOOLE_D .
  methods CREATE_VIEW
    importing
      !IV_VIEW_NAME type VIEWNAME
      !IV_VIEW_SOURCE type DDDDLSOURCE
      !IV_APP_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLIENT_DEPENDENT type BOOLE_D default ABAP_TRUE
    raising
      CX_DD_DDL_ACTIVATE
      CX_DD_DDL_SAVE
      CX_CFD_TRANSPORT_ADAPTER .
  methods DELETE_VIEW
    importing
      !IV_VIEW_NAME type VIEWNAME
    raising
      CX_DD_DDL_DELETE
      CX_CFD_TRANSPORT_ADAPTER .
  methods GET_FUNCTION_FOR_OBJECT
    importing
      !IV_OBJECT_TYPE type TCLO-OBTAB
    exporting
      !EV_FUNCTION_NAME type RS38L-NAME
      !EV_SY_SUBRC type I .
  methods GET_PRINT_PARAMETERS
    importing
      !IV_LINE_SIZE type PRI_PARAMS-LINSZ
      !IV_NO_DIALOG type BOOLE_D
    exporting
      !ES_OUT_PARAMETERS type PRI_PARAMS
      !EV_VALID type BOOLE_D
      !EV_SY_SUBRC type I .
  methods HAS_OBJECT_AREA
    returning
      value(RT_OBJECT_AREA) type TT_OBJECT_AREA .
  methods NEW_PAGE_PRINT_ON
    importing
      !IS_PRINT_PARAMETERS type PRI_PARAMS .
  methods NEW_PAGE_PRINT_OFF .
  methods WRITE_SPOOL
    importing
      !IV_OUT_STRING type STRING .
  methods DB_COMMIT .
  methods DB_ROLLBACK .
endinterface.