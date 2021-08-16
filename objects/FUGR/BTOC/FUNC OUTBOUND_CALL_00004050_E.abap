FUNCTION OUTBOUND_CALL_00004050_E.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  TABLES
*"      I_IBIN_BTE_APO_1_TAB STRUCTURE  IBINBTE_APO_1
*"----------------------------------------------------------------------
DATA: FMTAB LIKE FMRFC OCCURS 0 WITH HEADER LINE.

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
       EXPORTING
            I_EVENT       = '00004050'
       TABLES
            T_FMRFC       = FMTAB
       EXCEPTIONS
            NOTHING_FOUND = 4
            OTHERS        = 8.
  CHECK SY-SUBRC = 0.
  LOOP AT FMTAB.
    CHECK NOT FMTAB-FUNCT IS INITIAL.
    IF FMTAB-RFCDS IS INITIAL.

*------------- Open FI Interface with local destination ----------------
      CALL FUNCTION FMTAB-FUNCT
         TABLES
             I_BTE_TAB = I_IBIN_BTE_APO_1_TAB
         EXCEPTIONS
             OTHERS  = 1.


    ELSE.

*------------- Open FI Interface with foreign destination --------------
      CALL FUNCTION FMTAB-FUNCT
        DESTINATION FMTAB-RFCDS
        TABLES
            I_BTE_TAB = I_IBIN_BTE_APO_1_TAB
        EXCEPTIONS
            COMMUNICATION_FAILURE = 1
            SYSTEM_FAILURE        = 2.
      IF SY-SUBRC NE 0.
        MESSAGE E011(B!) WITH FMTAB-RFCDS.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.