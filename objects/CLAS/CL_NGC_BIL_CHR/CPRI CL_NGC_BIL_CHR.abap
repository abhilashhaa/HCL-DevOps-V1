private section.

  types:
    BEGIN OF lty_s_charc_delete_data,
      charcinternalid TYPE atinn,
      changenumber    TYPE aennr,
    END OF lty_s_charc_delete_data .
  types:
    lty_t_charc_delete_data TYPE STANDARD TABLE OF lty_s_charc_delete_data WITH DEFAULT KEY .
  types:
    BEGIN OF lty_s_charcval_create,
        created                  TYPE abap_bool,
        cid                      TYPE string,
        charcvaluepositionnumber TYPE atzhl,
        value_from               TYPE atflv,
        value_to                 TYPE atflb,
        value_relation           TYPE atcod,
        unit_from                TYPE meins,
        unit_to                  TYPE meins,
        unit_from_iso            TYPE meins_iso,
        unit_to_iso              TYPE meins_iso,
        default_value            TYPE atstd,
        document_no              TYPE doknr,
        document_type            TYPE dokar,
        document_part            TYPE doktl_d,
        document_version         TYPE dokvr,
        charcvalue               TYPE atwrt,
        value_char               TYPE atwrt30,
        value_char_high          TYPE atwrt30,
        value_char_long          TYPE atwrt70,
        value_char_high_long     TYPE atwrt70,
        currency_from            TYPE waers,
        currency_to              TYPE waers,
        currency_from_iso        TYPE isocd,
        currency_to_iso          TYPE isocd,
      END OF lty_s_charcval_create .
  types:
    lty_t_charcval_create TYPE STANDARD TABLE OF lty_s_charcval_create WITH DEFAULT KEY .
  types:
    BEGIN OF lty_s_charc_create.
        INCLUDE TYPE bapicharactdetail AS bapi_data.
    TYPES: charcinternalid TYPE atinn.
    TYPES: cid TYPE string.
    TYPES: END OF lty_s_charc_create .
  types:
    lty_t_charc_create TYPE STANDARD TABLE OF lty_s_charc_create WITH DEFAULT KEY .
  types:
    BEGIN OF lty_s_charc_data,
        changenumber TYPE aennr,
        charc        TYPE lty_s_charc_create,
        charcdesc    TYPE tt_bapicharactdescr,
        charcref     TYPE tt_bapicharactreferences,
        charcrstr    TYPE tt_bapicharactrestrictions,
        charcval     TYPE lty_t_charcval_create,
        charcvaldesc TYPE tt_bapicharactvaluesdescr,
      END OF lty_s_charc_data .
  types:
    lty_t_charc_data TYPE TABLE OF lty_s_charc_data WITH DEFAULT KEY .

  constants:
    BEGIN OF gs_charcvaldependency,
        eq    TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '1',
        ge_lt TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '2',
        ge_le TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '3',
        gt_lt TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '4',
        gt_le TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '5',
        lt    TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '6',
        le    TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '7',
        gt    TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '8',
        ge    TYPE lty_clfn_charc_cds-s_charcvalue-charcvaluedependency VALUE '9',
      END OF gs_charcvaldependency .
  class-data GO_INSTANCE type ref to IF_NGC_BIL_CHR .
  data MO_SY_MESSAGE_CONVERT type ref to IF_RAP_PLMI_SY_MSG_CONVERT .
  data MO_BAPI_MESSAGE_CONVERT type ref to IF_RAP_PLMI_BAPI_MSG_CONVERT .
  data MO_VDM_API_MAPPER type ref to IF_VDM_PLMB_API_MAPPER .
  data MO_NGC_DB_ACCESS type ref to IF_NGC_RAP_CHR_BAPI_UTIL .
  data MT_CHARC_DELETE_DATA type LTY_T_CHARC_DELETE_DATA .
  data MT_CHARC_CREATE_DATA type LTY_T_CHARC_DATA .
  data MT_CHARC_CHANGE_DATA type LTY_T_CHARC_DATA .
  constants GC_ERROR_TYPES type STRING value 'EAX' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IO_SY_MSG_CONVERT type ref to IF_RAP_PLMI_SY_MSG_CONVERT
      !IO_BAPI_MESSAGE_CONVERT type ref to IF_RAP_PLMI_BAPI_MSG_CONVERT
      !IO_VDM_API_MAPPER type ref to IF_VDM_PLMB_API_MAPPER
      !IO_CHR_BAPI_UTIL type ref to IF_NGC_RAP_CHR_BAPI_UTIL .
  methods LOAD_CHARC_DATA
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_CHANGENUMBER type AENNR optional
    returning
      value(RV_NEW) type ABAP_BOOL .
  methods LOAD_CHARC_DATA_INCL_DELETED
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_CHANGENUMBER type AENNR optional
    returning
      value(RV_NEW) type ABAP_BOOL .
  methods MODIFY_CHARC_DATA
    importing
      !IS_CHARC_DATA type LTY_S_CHARC_DATA
      !IV_DEEP_INSERT type ABAP_BOOL optional
    returning
      value(RT_RETURN) type BAPIRETTAB .
  methods MAP_CHARC_VDM_API
    importing
      !IS_CHARC_VDM type I_CLFNCHARCFORKEYDATETP optional
      !IS_CHARC_VDM_UPD type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCTP-S_UPDATE optional
      !IS_CHARC_API type LTY_S_CHARC_CREATE optional
    returning
      value(RS_CHARC_API) type BAPICHARACTDETAIL .
  methods MAP_CHARC_DESC_VDM_API
    importing
      !IS_CHARC_DESC_VDM type I_CLFNCHARCDESCFORKEYDATETP
    returning
      value(RS_CHARC_DESC_API) type BAPICHARACTDESCR .
  methods MAP_CHARC_RSTR_VDM_API
    importing
      !IS_CHARC_RSTR_VDM type I_CLFNCHARCRSTRCNFORKEYDATETP
    returning
      value(RS_CHARC_RSTR_API) type BAPICHARACTRESTRICTIONS .
  methods MAP_CHARC_REF_VDM_API
    importing
      !IS_CHARC_REF_VDM type I_CLFNCHARCREFFORKEYDATETP
    returning
      value(RS_CHARC_REF_API) type BAPICHARACTREFERENCES .
  methods MAP_CHARC_VAL_VDM_API
    importing
      !IS_CHARC_VAL_VDM type I_CLFNCHARCVALFORKEYDATETP optional
      !IS_CHARC_VAL_VDM_UPD type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALTP-S_UPDATE optional
      !IS_CHARC_API type LTY_S_CHARC_CREATE optional
      !IS_CHARC_VAL_API type LTY_S_CHARCVAL_CREATE optional
    returning
      value(RS_CHARC_VAL_API) type LTY_S_CHARCVAL_CREATE .
  methods MAP_CHARC_VAL_DESC_VDM_API
    importing
      !IS_CHARC_VAL_DESC_VDM type I_CLFNCHARCVALDESCFORKEYDATETP
      !IS_CHARC_VAL type LTY_S_CHARCVAL_CREATE
    returning
      value(RS_CHARC_VAL_DESC_API) type BAPICHARACTVALUESDESCR .
  methods MAP_API_INT_TO_EXT
    importing
      !IS_CHARC_DATA type LTY_S_CHARC_DATA
    exporting
      !ET_CHARC type TT_BAPICHARACTDETAIL
      !ET_CHARC_VAL_CHAR type TT_BAPICHARACTVALUESCHAR
      !ET_CHARC_VAL_NUM type TT_BAPICHARACTVALUESNUM
      !ET_CHARC_VAL_CURR type TT_BAPICHARACTVALUESCURR .
  methods MAP_API_EXT_TO_INT
    importing
      !IT_CHARC type TT_BAPICHARACTDETAIL
      !IT_CHARC_VAL type LTY_T_CHARCVAL_CREATE
      !IV_CHARCINTERNALID type ATINN
    returning
      value(RS_CHARC_DATA) type LTY_S_CHARC_DATA .
  methods ADD_CHARC_MESSAGE
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_CID type STRING
      !IV_SET_FAILED type ABAP_BOOL
      !IV_NEW type ABAP_BOOL optional
      !IS_BAPIRET type BAPIRET2 optional
    changing
      !CT_REPORTED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCTP-T_FAILED .
  methods ADD_CHARC_DESC_MESSAGE
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_ROOT_CHARCINTERNALID type ATINN optional
      !IV_LANGUAGE type SPRAS
      !IV_CID type STRING
      !IV_SET_FAILED type ABAP_BOOL
      !IV_NEW type ABAP_BOOL optional
      !IS_BAPIRET type BAPIRET2 optional
    changing
      !CT_REPORTED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCDESCTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCDESCTP-T_FAILED .
  methods ADD_CHARC_RSTR_MESSAGE
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_CLASSTYPE type KLASSENART
      !IV_ROOT_CHARCINTERNALID type ATINN optional
      !IV_CID type STRING
      !IV_SET_FAILED type ABAP_BOOL
      !IV_NEW type ABAP_BOOL optional
      !IS_BAPIRET type BAPIRET2 optional
    changing
      !CT_REPORTED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCRSTRCNTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCRSTRCNTP-T_FAILED .
  methods ADD_CHARC_REF_MESSAGE
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_CHARC_REF_TABLE type ATTAB
      !IV_CHARC_REF_FIELD type ATFEL
      !IV_ROOT_CHARCINTERNALID type ATINN optional
      !IV_CID type STRING
      !IV_SET_FAILED type ABAP_BOOL
      !IV_NEW type ABAP_BOOL optional
      !IS_BAPIRET type BAPIRET2 optional
    changing
      !CT_REPORTED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCREFTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCREFTP-T_FAILED .
  methods ADD_CHARC_VAL_MESSAGE
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_POSITION_NUMBER type ATZHL
      !IV_ROOT_CHARCINTERNALID type ATINN optional
      !IV_CID type STRING
      !IV_SET_FAILED type ABAP_BOOL
      !IV_NEW type ABAP_BOOL optional
      !IS_BAPIRET type BAPIRET2 optional
    changing
      !CT_REPORTED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALTP-T_FAILED .
  methods ADD_CHARC_VAL_DESC_MESSAGE
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_LANGUAGE type SPRAS
      !IV_POSITION_NUMBER type ATZHL
      !IV_ROOT_CHARCINTERNALID type ATINN optional
      !IV_CID type STRING
      !IV_SET_FAILED type ABAP_BOOL
      !IV_NEW type ABAP_BOOL optional
      !IS_BAPIRET type BAPIRET2 optional
    changing
      !CT_REPORTED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALDESCTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALDESCTP-T_FAILED .
  methods GET_ANCESTOR_IDX
    importing
      !IV_CID_REF type STRING
      !IV_CHANGENUMBER type AENNR optional
    exporting
      !EV_ROOT_IDX type I
      !EV_PARENT_IDX type I
      !EV_DIFFERENT_CHANGENUMBER type BOOLE_D .
  methods CHECK_CHARC_EXISTS_BY_NAME
    importing
      !IV_CHARACTERISTIC type ATNAM
      !IV_KEYDATE type SYDATE default SY-DATUM
    returning
      value(RV_EXISTS) type ABAP_BOOL .
  methods CHECK_CHARC_EXISTS_BY_ID
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_KEYDATE type DATS default SY-DATUM
    returning
      value(RV_EXISTS) type ABAP_BOOL .
  methods READ_CHARACTERISTIC_BY_ID
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_KEYDATE type DATS default SY-DATUM
    returning
      value(RS_CHARACTERISTIC) type I_CLFNCHARCFORKEYDATETP .
  methods READ_CHARACTERISTIC_DATA_BY_ID
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_KEYDATE type DATS default SY-DATUM
    exporting
      !ES_CHARACTERISTIC type LTY_CLFN_CHARC_CDS-S_CHARC
      !ET_CHARACTERISTICDESC type LTY_CLFN_CHARC_CDS-T_CHARCDESC
      !ET_CHARACTERISTICREF type LTY_CLFN_CHARC_CDS-T_CHARCREF
      !ET_CHARACTERISTICRSTRCN type LTY_CLFN_CHARC_CDS-T_CHARCRSTRCN
      !ET_CHARACTERISTICVALUE type LTY_CLFN_CHARC_CDS-T_CHARCVALUE
      !ET_CHARACTERISTICVALUEDESC type LTY_CLFN_CHARC_CDS-T_CHARCVALUEDESC .
  methods READ_CHARC_DATA_BY_ID_INCL_DEL
    importing
      !IV_CHARCINTERNALID type ATINN
      !IV_KEYDATE type DATS default SY-DATUM
    exporting
      !ES_CHARACTERISTIC type LTY_CLFN_CHARC_CDS-S_CHARC
      !ET_CHARACTERISTICDESC type LTY_CLFN_CHARC_CDS-T_CHARCDESC
      !ET_CHARACTERISTICREF type LTY_CLFN_CHARC_CDS-T_CHARCREF
      !ET_CHARACTERISTICRSTRCN type LTY_CLFN_CHARC_CDS-T_CHARCRSTRCN
      !ET_CHARACTERISTICVALUE type LTY_CLFN_CHARC_CDS-T_CHARCVALUE
      !ET_CHARACTERISTICVALUEDESC type LTY_CLFN_CHARC_CDS-T_CHARCVALUEDESC .