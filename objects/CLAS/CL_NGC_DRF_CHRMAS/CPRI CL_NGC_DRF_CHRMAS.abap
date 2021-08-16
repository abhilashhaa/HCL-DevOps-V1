private section.

  types:
    tt_chr_key TYPE STANDARD TABLE OF api_charac .

  class-data GO_DRF_CHRMAS type ref to CL_NGC_DRF_CHRMAS .
  data MS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .
  data MV_BUS_SYS_FETCHED type BOOLE_D value ABAP_FALSE ##NO_TEXT.
  data MT_CHR_KEY type TT_CHR_KEY .
  data MO_DRF_ACCESS_CUST_DATA type ref to LIF_DRF_ACCESS_CUST_DATA .
  data MO_NGC_DRF_UTIL type ref to IF_NGC_DRF_UTIL .
  data MO_DRF_ALE_INFO type ref to LIF_DRF_ALE_INFO .
  data MO_IDOC_FUNCTIONS type ref to LIF_IDOC_FUNCTIONS .

  methods UPDATE_REPLICATION_DATA
    importing
      !IV_OBJECT_ID type DRF_OBJECT_ID optional
      !IT_IDOC_RESULT type EDIDC_TT
      !IV_MESSAGETYPE type EDI_DOCTYP
    changing
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL optional .
  methods HANDLE_CHR_DATA
    importing
      !IV_PACKET_SIZE type DRF_PACKAGE_SIZE
    changing
      !CT_CHR_KEY type TT_CHR_KEY .
  methods SEND_CHRMAS_IDOC
    importing
      !IT_CHR_KEY type TT_CHR_KEY
    changing
      !CT_IDOC_CNTRL type EDIDC_TT
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL .