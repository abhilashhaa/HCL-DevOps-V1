FUNCTION OUTBOUND_CALL_01010002_P.
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
  DATA: LOGSYS TYPE LOGSYS,
        MSGNO  LIKE SY-MSGNO.
  DATA: FMTAB      LIKE FMRFC OCCURS 0 WITH HEADER LINE,
        MSGTXT(80) TYPE C.

  CALL FUNCTION 'PC_FUNCTION_FIND'
       EXPORTING
            I_PROCS       = '01010002'
       TABLES
            T_FMRFC       = FMTAB
       EXCEPTIONS
            NOTHING_FOUND = 4
            OTHERS        = 8.

  CHECK SY-SUBRC = 0.

  MOVE RFCDEST TO LOGSYS.      "Conversion from RFC Dest to log. System
  MOVE MSGNR   TO MSGNO.       "Conversion from T100-MSGNR to SY-MSGNO

  LOOP AT FMTAB.
    CHECK NOT FMTAB-FUNCT IS INITIAL.
    IF FMTAB-RFCDS IS INITIAL.
      CALL FUNCTION FMTAB-FUNCT
             EXPORTING
                  SPRSL       = SPRSL
                  ARBGB       = ARBGB
                  MSGNR       = MSGNO
                  LOGSYS      = LOGSYS
             IMPORTING
                  TEXT        = TEXT
                  GRU1        = GRU1
                  GRU2        = GRU2
                  VEBE        = VEBE
                  VBFIX       = VBFIX
                  TCMF1_MSG   = TCMF1_MSG
             EXCEPTIONS
                  OTHERS                = 1.

    ELSE.
      CALL FUNCTION FMTAB-FUNCT
      DESTINATION FMTAB-RFCDS
             EXPORTING
                  SPRSL       = SPRSL
                  ARBGB       = ARBGB
                  MSGNR       = MSGNO
                  LOGSYS      = LOGSYS
             IMPORTING
                  TEXT        = TEXT
                  GRU1        = GRU1
                  GRU2        = GRU2
                  VEBE        = VEBE
                  VBFIX       = VBFIX
                  TCMF1_MSG   = TCMF1_MSG
             EXCEPTIONS
                  SYSTEM_FAILURE        = 1 MESSAGE MSGTXT
                  COMMUNICATION_FAILURE = 2 MESSAGE MSGTXT
                  OTHERS                = 3.
      IF SY-SUBRC = 1
      OR SY-SUBRC = 2.
        MESSAGE E002(AG) WITH FMTAB-FUNCT
                              MSGTXT.
*    Fehler bei RFC-Aufruf: &1, &2
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.