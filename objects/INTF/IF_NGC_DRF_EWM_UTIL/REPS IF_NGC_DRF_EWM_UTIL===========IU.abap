interface IF_NGC_DRF_EWM_UTIL
  public .


  types:
    tt_cif_cabn  TYPE STANDARD TABLE OF cabn_cif_ext WITH NON-UNIQUE DEFAULT KEY .
  types:
    tt_cif_cawn  TYPE STANDARD TABLE OF cif_cawn  WITH NON-UNIQUE DEFAULT KEY .
  types:
    tt_cif_cawnt TYPE STANDARD TABLE OF cif_cawnt WITH NON-UNIQUE DEFAULT KEY .
  types:
    tt_extensionin TYPE TABLE OF /sapapo/cifbparex .
  types:
    BEGIN OF ty_s_field_names,
      key_filter_field_name  TYPE string,
      check_against_name     TYPE string,
    END OF ty_s_field_names .
  types:
    ty_t_field_names TYPE STANDARD TABLE OF ty_s_field_names .
  types:
    BEGIN OF ty_s_clf_batch_key,
      object_table    TYPE tabelle,
      klart           TYPE klassenart,
      objkey          TYPE cuobn,
      matnrwerkscharg TYPE drf_object_id,
    END OF ty_s_clf_batch_key .
  types:
    ty_t_clf_batch_key TYPE SORTED TABLE OF ty_s_clf_batch_key WITH UNIQUE KEY object_table klart objkey .

  methods CHANGE_CLASSTYPE_TCME
    importing
      !IV_CLASS_TYPE_FROM type KLASSENART
      !IV_CLASS_TYPE_TO type KLASSENART
    changing
      !CT_TCME type TT_TCME
      !CS_CTRLPARAMS type CIFCTRLPAR .
  methods APO_IRRELEVANT_TCME
    changing
      !CT_TCME type TT_TCME
      !CS_CTRLPARAMS type CIFCTRLPAR .
  methods EXPAND_TCME_FOR_CDP
    changing
      !CT_TCME type TT_TCME
      !CS_CTRLPARAMS type CIFCTRLPAR .
  methods CHANGE_CLASSTYPE_CLASS
    importing
      !IV_CLASS_TYPE_FROM type KLASSENART
      !IV_CLASS_TYPE_TO type KLASSENART
      !IS_CTRLPARAMS type CIFCTRLPAR
    changing
      !CT_KLAH type TT_KLAH
      !CT_KSML type TT_KSML .
  methods APO_IRRELEVANT_TYPES_CLASS
    changing
      !CT_KLAH type TT_KLAH
      !CT_KSML type TT_KSML
      !CS_CTRLPARAMS type CIFCTRLPAR .
  methods GET_SELECTED_CLASSIFICATIONS
    importing
      !IT_RANGE_KLART type RSDSSELOPT_T optional
      !IT_RANGE_OBTAB type RSDSSELOPT_T optional
      !IT_RANGE_CLASS type RSDSSELOPT_T optional
      !IT_RANGE_MATNR type RSDSSELOPT_T optional
      !IT_RANGE_LGNUM type RSDSSELOPT_T optional
      !IV_ADDITIONAL_WHERE_CND type STRING optional
    exporting
      !ET_CLF_KEY type TY_T_CLF_BATCH_KEY .
  methods CIF_MFLE_MAP_CLCG_EXPORT_MASS
    importing
      !IS_MATNR_FIELDNAMES type CL_MFLE_CIF_CLCG_MAPPER=>TY_S_FIELDNAMES optional
      !IT_TABLE type INDEX TABLE
      !IS_CUOBN_FIELDNAMES type CL_MFLE_CIF_CLCG_MAPPER=>TY_S_FIELDNAMES optional
      !IT_CHAR_FIELDNAMES type CL_MFLE_CIF_CLCG_MAPPER=>TY_T_CHAR_FIELDNAMES optional
      !IT_CUX_FIELDNAMES type CL_MFLE_CIF_CLCG_MAPPER=>TY_T_CUX_FIELDNAMES optional
    exporting
      !ET_TABLE type INDEX TABLE
    raising
      CX_CLS_CHK_MAPPER .
  methods CIF_MFLE_SET_BUF
    importing
      !IT_TABLE type INDEX TABLE .
  methods CIF_MFLE_RESET_BUF .
  methods ALE_OWN_LOGICAL_SYSTEM_GET
    exporting
      value(EV_OWN_LOGICAL_SYSTEM) type LOGSYS
      !EV_SUBRC type SY-SUBRC .
  methods RFC_TRFC_SET_QIN_PROPERTIES
    importing
      value(IV_QOUT_NAME) type TRFCQOUT-QNAME default SPACE
      value(IV_QIN_NAME) type TRFCQIN-QNAME
      value(IV_QIN_COUNT) type TRFCQIN-QCOUNT optional
      value(IV_CALL_EVENT) type SY-INPUT default SPACE
      value(IV_NO_EXECUTE) type SY-INPUT default SPACE
    exporting
      !EV_SUBRC type SY-SUBRC .
  methods CIF_/SAPAPO/CIF_CHR30_INB
    importing
      value(IV_RFC_DEST) type RFCDEST
      value(IS_CONTROL_PARAMETER) type /SAPAPO/CIF_CTRLPARAM optional
    changing
      !CT_CABN type TT_CIF_CABN optional
      !CT_CABNT type TT_CABNT optional
      !CT_CAWN type TT_CIF_CAWN optional
      !CT_CAWNT type TT_CIF_CAWNT optional
      !CT_CABNZ type TT_CABNZ optional
      !CT_TCME type TT_TCME optional
      !CT_EXTENSIONIN type TT_EXTENSIONIN optional
      !CT_RETURN type BAPIRETTAB .
  methods GET_OBJECT_FILTER
    importing
      !IT_UNFILTERED_OBJECTS type SORTED TABLE
      !IT_FIELD_NAMES type TY_T_FIELD_NAMES
    returning
      value(RV_RESULT) type STRING .
  methods REP_STA_BY_BO_INST_SYSTEM_GET
    importing
      !IV_BUSINESS_SYSTEM type MDG_BUSINESS_SYSTEM
      !IV_BO type MDG_OBJECT_TYPE_CODE_BS
      !IV_OBJECT_ID type DRF_OBJECT_ID
    exporting
      !ET_REPLICATION type DRF_T_OBJ_REP_STA_FULL .
  methods GET_SELECTED_CHARACTERISTICS
    importing
      !IT_RANGE_ATNAM type RSDSSELOPT_T optional
      !IT_RANGE_KLART type RSDSSELOPT_T optional
      !IT_RANGE_CLASS type RSDSSELOPT_T optional
      !IV_ADDITIONAL_WHERE_CND type STRING
    exporting
      !ET_CHR_KEY type NGCT_DRF_CHRMAS_OBJECT_KEY .
  methods GET_SELECTED_CLASSES
    importing
      !IT_RANGE_KLART type RSDSSELOPT_T optional
      !IT_RANGE_CLASS type RSDSSELOPT_T optional
      !IV_ADDITIONAL_WHERE_CND type STRING optional
    exporting
      !ET_CLS_KEY type NGCT_DRF_CLSMAS_OBJECT_KEY .
  methods GET_CLASS_DATA
    importing
      !IT_BO_KEY type NGCT_DRF_CLSMAS_OBJECT_KEY optional
    exporting
      !ET_CLASS_HEADER type TT_KLAH
      !ET_CHARACT_TAB type TT_KSML
      !ET_CATCHWORD_TAB type TT_SWOR .
  methods GET_CLASSIFICATION_DATA
    importing
      !IT_BO_KEYS type NGCT_DRF_CLFMAS_OBJECT_KEY optional
    exporting
      !ET_KSSK_CLASSIFICATION type TT_KSSK
      !ET_INOB_CLASSIFICATION type TT_INOB
      !ET_AUSP_CLASSIFICATION type TT_AUSP .
endinterface.