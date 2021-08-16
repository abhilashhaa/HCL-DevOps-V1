class CL_NGC_DRF_EWM_CHR definition
  public
  create private .

public section.

  interfaces IF_DRF_OUTBOUND .

  class-methods SEND_CIF_CHARACTERISTIC
    importing
      !IS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT
      !IO_NGC_DRF_EWM_UTIL type ref to IF_NGC_DRF_EWM_UTIL
      !IT_CABN type TT_CABN
      !IT_CABNT type TT_CABNT
      !IT_CAWN type TT_CAWN
      !IT_CAWNT type TT_CAWNT
      !IT_CABNZ type TT_CABNZ
      !IT_TCME type TT_TCME
    changing
      !CT_OBJ_REP_STA type DRF_T_OBJ_REP_STA_FULL
    raising
      CX_DRF_PROCESS_MESSAGES .