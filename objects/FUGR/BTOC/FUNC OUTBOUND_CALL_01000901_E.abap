FUNCTION OUTBOUND_CALL_01000901_E.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"       TABLES
*"              ET_ALLOCATION_TAB STRUCTURE  RMCLKSSK
*"              ET_VALUE_TAB STRUCTURE  RMCLAUSP
*"              ET_DELOB_TAB STRUCTURE  RMCLDOB
*"----------------------------------------------------------------------
* CA Klassensystem - Klassenzuordnung vor Verbuchung
*
*"----------------------------------------------------------------------

  DATA: LT_FMTAB LIKE FMRFC OCCURS 0 WITH HEADER LINE.

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
       EXPORTING
            I_EVENT       = '01000901'
       TABLES
            T_FMRFC       = LT_FMTAB
       EXCEPTIONS
            NOTHING_FOUND = 4
            OTHERS        = 8.

  CHECK SY-SUBRC = 0.

  LOOP AT LT_FMTAB.
    CHECK NOT LT_FMTAB-FUNCT IS INITIAL.
    IF LT_FMTAB-RFCDS IS INITIAL.

      CALL FUNCTION LT_FMTAB-FUNCT
    TABLES
         ET_ALLOCATION_TAB = ET_ALLOCATION_TAB
         ET_VALUE_TAB      = ET_VALUE_TAB
         ET_DELOB_TAB      = ET_DELOB_TAB
     EXCEPTIONS
          OTHERS            = 1.


    ELSE.
      CALL FUNCTION LT_FMTAB-FUNCT
           DESTINATION FMTAB-RFCDS
    TABLES
         ET_ALLOCATION_TAB = ET_ALLOCATION_TAB
         ET_VALUE_TAB      = ET_VALUE_TAB
         ET_DELOB_TAB      = ET_DELOB_TAB
           EXCEPTIONS
           COMMUNICATION_FAILURE = 1
           SYSTEM_FAILURE = 2
                OTHERS      = 3.
    ENDIF.
  ENDLOOP.




ENDFUNCTION.