private section.

  types:
    tt_edidc TYPE STANDARD TABLE OF edidc .
  types:
    begin of ts_clf_data.
      include type clobjekte as clobjekte.
      types: klart TYPE klassenart.
    types: end of ts_clf_data .
  types:
    tt_clobjekte TYPE STANDARD TABLE OF ts_clf_data .

  class-data GO_DRF_CLFMAS type ref to CL_NGC_DRF_CLFMAS .
  data MS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  data MV_BUS_SYS_FETCHED type BOOLE_D value ABAP_FALSE ##NO_TEXT.
  data MT_CLF_DATA type TT_CLOBJEKTE .
  data MO_DRF_ACCESS_CUST_DATA type ref to LIF_DRF_ACCESS_CUST_DATA .
  data MO_NGC_DRF_UTIL type ref to IF_NGC_DRF_UTIL .
  data MO_DRF_ALE_INFO type ref to LIF_DRF_ALE_INFO .
  data MO_IDOC_FUNCTIONS type ref to LIF_IDOC_FUNCTIONS .

  methods UPDATE_REPLICATION_DATA
    importing
      !IV_OBJECT_ID type DRF_OBJECT_ID optional
      !IT_IDOC_RESULT type TT_EDIDC
      !IV_MESSAGETYPE type EDI_DOCTYP
    changing
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL optional .
  methods HANDLE_CLF_DATA
    importing
      !IV_PACKET_SIZE type DRF_PACKAGE_SIZE
    changing
      !CT_CLF_DATA type TT_CLOBJEKTE .
  methods SEND_CLFMAS_IDOC
    importing
      !IT_CLF_DATA type TT_CLOBJEKTE
    changing
      !CT_IDOC_CNTRL type TT_EDIDC
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL .