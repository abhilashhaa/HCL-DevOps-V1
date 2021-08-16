FUNCTION SAMPLE_PROCESS_01010002.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(RFCDEST) TYPE  RFCDEST
*"             VALUE(SPRSL) TYPE  LANGU DEFAULT SY-LANGU
*"             VALUE(ARBGB) TYPE  ARBGB
*"             VALUE(MSGNR) TYPE  MSGNR
*"       EXPORTING
*"             VALUE(TEXT) LIKE  T100-TEXT
*"             VALUE(GRU1) LIKE  CMFP-GRU1
*"             VALUE(GRU2) LIKE  CMFP-GRU2
*"             VALUE(VEBE) LIKE  CMFP-VEBE
*"             VALUE(VBFIX) LIKE  CMFP-VBFIX
*"             VALUE(TCMF1_MSG) TYPE  CHAR1
*"       EXCEPTIONS
*"              NO_SY_MESSAGE
*"----------------------------------------------------------------------


ENDFUNCTION.