class CL_NGC_CORE_DATA_CONV definition
  public
  abstract
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .

  class-methods INIT_LOGGER
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME .
  class-methods CHECK_AUTHORITY
    returning
      value(RV_FAILED) type BOOLE_D .
  methods CONSTRUCTOR
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLIENT type MANDT
      !IV_REWORK type BOOLE_D .
  methods CONVERT_CLIENT
  abstract .
  methods PROCESS_PACKAGE
  abstract
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    raising
      CX_SHDB_PFW_APPL_ERROR .
  methods AFTER_PACKAGE
    raising
      CX_SHDB_PFW_APPL_ERROR .
  class-methods GET_CURRENT_TIME
    returning
      value(RV_TIME) type STRING .
  class-methods CREATE_VIEW
    importing
      !IV_VIEW_NAME type VIEWNAME
      !IV_VIEW_SOURCE type DDDDLSOURCE
      !IV_APP_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLIENT_DEPENDENT type BOOLE_D default ABAP_TRUE
    raising
      CX_DD_DDL_ACTIVATE
      CX_DD_DDL_SAVE
      CX_CFD_TRANSPORT_ADAPTER .
  class-methods DELETE_VIEW
    importing
      !IV_VIEW_NAME type VIEWNAME
    raising
      CX_DD_DDL_DELETE
      CX_CFD_TRANSPORT_ADAPTER .
  class-methods CREATE_NODELEAF_VIEW
    importing
      !IV_VIEW_NAME type VIEWNAME
      !IV_APP_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLIENT_DEPENDENT type BOOLE_D default ABAP_TRUE
    raising
      CX_DD_DDL_ACTIVATE
      CX_DD_DDL_SAVE
      CX_CFD_TRANSPORT_ADAPTER .