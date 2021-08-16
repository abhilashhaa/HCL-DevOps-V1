FUNCTION SAMPLE_PROCESS_01010003.
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

ENDFUNCTION.