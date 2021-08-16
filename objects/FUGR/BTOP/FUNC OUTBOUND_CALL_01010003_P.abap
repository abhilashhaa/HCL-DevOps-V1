FUNCTION OUTBOUND_CALL_01010003_P.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(RFCDEST) TYPE  RFCDEST
*"             VALUE(DOKCLASS) LIKE  DSYSH-DOKCLASS
*"             VALUE(DOKLANGU) LIKE  DSYSH-DOKLANGU DEFAULT SY-LANGU
*"             VALUE(DOKNAME)
*"             VALUE(DOKTITLE) LIKE  DSYST-DOKTITLE DEFAULT SPACE
*"             VALUE(CALLED_BY_PROGRAM) LIKE  HELP_INFO-PROGRAM
*"                             DEFAULT SPACE
*"             VALUE(CALLED_BY_DYNP) LIKE  HELP_INFO-DYNPRO
*"                             DEFAULT SPACE
*"             VALUE(CALLED_FOR_TAB) LIKE  HELP_INFO-TABNAME
*"                             DEFAULT SPACE
*"             VALUE(CALLED_FOR_FIELD) LIKE  HELP_INFO-FIELDNAME
*"                             DEFAULT SPACE
*"             VALUE(CALLED_FOR_TAB_FLD_BTCH_INPUT)
*"                             LIKE  HELP_INFO-DYNPROFLD
*"                             DEFAULT SPACE
*"             VALUE(MSG_VAR_1) DEFAULT SPACE
*"             VALUE(MSG_VAR_2) DEFAULT SPACE
*"             VALUE(MSG_VAR_3) DEFAULT SPACE
*"             VALUE(MSG_VAR_4) DEFAULT SPACE
*"             VALUE(CALLED_BY_CUAPROG) LIKE  HELP_INFO-PROGRAM
*"                             DEFAULT SPACE
*"             VALUE(CALLED_BY_CUASTAT) LIKE  HELP_INFO-PFKEY
*"                             OPTIONAL
*"             VALUE(SHORT_TEXT) LIKE  SY-BATCH DEFAULT SPACE
*"       TABLES
*"              LINKS STRUCTURE  TLINE
*"       EXCEPTIONS
*"              OBJECT_NOT_FOUND
*"              SAPSCRIPT_ERROR
*"----------------------------------------------------------------------
  data: logsys type logsys.
  DATA: FMTAB      LIKE FMRFC OCCURS 0 WITH HEADER LINE,
        MSGTXT(80) TYPE C.

  CALL FUNCTION 'PC_FUNCTION_FIND'
       EXPORTING
            I_PROCS       = '01010003'
       TABLES
            T_FMRFC       = FMTAB
       EXCEPTIONS
            NOTHING_FOUND = 4
            OTHERS        = 8.

  CHECK SY-SUBRC = 0.

  move rfcdest to logsys.      "Conversion from RFC Dest to log. System

  LOOP AT FMTAB.
    CHECK NOT FMTAB-FUNCT IS INITIAL.
    if fmtab-rfcds is initial.
      CALL FUNCTION FMTAB-FUNCT
           EXPORTING
                dokclass                      = dokclass
                DOKLANGU                      = doklangu
                dokname                       = dokname
                DOKTITLE                      = doktitle
                CALLED_BY_PROGRAM             = CALLED_BY_PROGRAM
                CALLED_BY_DYNP                = CALLED_BY_DYNP
                CALLED_FOR_TAB                = CALLED_FOR_TAB
                CALLED_FOR_FIELD              = CALLED_FOR_FIELD
                CALLED_FOR_TAB_FLD_BTCH_INPUT =
                                     CALLED_FOR_TAB_FLD_BTCH_INPUT
                MSG_VAR_1                     = MSG_VAR_1
                MSG_VAR_2                     = MSG_VAR_2
                MSG_VAR_3                     = MSG_VAR_3
                MSG_VAR_4                     = MSG_VAR_4
                CALLED_BY_CUAPROG             = CALLED_BY_CUAPROG
                CALLED_BY_CUASTAT             = CALLED_BY_CUASTAT
                SHORT_TEXT                    = SHORT_TEXT
                logsys                        = logsys
           tables
                links                         = links
           exceptions
                others                = 1.
     else.
      CALL FUNCTION FMTAB-FUNCT
      destination fmtab-rfcds
           EXPORTING
                dokclass                      = dokclass
                DOKLANGU                      = doklangu
                dokname                       = dokname
                DOKTITLE                      = doktitle
                CALLED_BY_PROGRAM             = CALLED_BY_PROGRAM
                CALLED_BY_DYNP                = CALLED_BY_DYNP
                CALLED_FOR_TAB                = CALLED_FOR_TAB
                CALLED_FOR_FIELD              = CALLED_FOR_FIELD
                CALLED_FOR_TAB_FLD_BTCH_INPUT =
                                     CALLED_FOR_TAB_FLD_BTCH_INPUT
                MSG_VAR_1                     = MSG_VAR_1
                MSG_VAR_2                     = MSG_VAR_2
                MSG_VAR_3                     = MSG_VAR_3
                MSG_VAR_4                     = MSG_VAR_4
                CALLED_BY_CUAPROG             = CALLED_BY_CUAPROG
                CALLED_BY_CUASTAT             = CALLED_BY_CUASTAT
                SHORT_TEXT                    = SHORT_TEXT
                logsys                        = logsys
           tables
                links                         = links
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