FUNCTION OUTBOUND_CALL_01000010_E.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(BUDAT) LIKE  MKPF-BUDAT DEFAULT SY-DATLO
*"     VALUE(USNAM) LIKE  MKPF-USNAM DEFAULT SY-UNAME
*"     REFERENCE(IT_STOCK_CHANGE) TYPE  NSDM_T_BTE_STOCK OPTIONAL
*"  TABLES
*"      XMARC STRUCTURE  SMARC
*"      XMARD STRUCTURE  SMARD
*"      XMCH1 STRUCTURE  SMCH1
*"      XMCHA STRUCTURE  SMCHA
*"      XMCHB STRUCTURE  SMCHB
*"      XMKOL STRUCTURE  SMKOL
*"      XMSKA STRUCTURE  SMSKA
*"      XMSKU STRUCTURE  SMSKU
*"      XMSLB STRUCTURE  SMSLB
*"      XMSPR STRUCTURE  SMSPR
*"      XMSSA STRUCTURE  SMSSA
*"      XMSSL STRUCTURE  SMSSL
*"      XMSSQ STRUCTURE  SMSSQ
*"      /SPE/PLANTRIGGER_TIMESTAMP STRUCTURE
*"        /SPE/PLANTRIGGER_AFS_TIMESTAMP OPTIONAL
*"----------------------------------------------------------------------

************************************************************************

********* SAMPLE FOR NORMAL EVENT WITHOUT EXPORT TO MEMORY *************

************************************************************************
  DATA: lt_whitelist TYPE string_hashed_table,
        lv_whitelist TYPE string.

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
    EXPORTING
      I_EVENT       = '01000010'
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
           EXPORTING
                BUDAT = BUDAT
                USNAM = USNAM
                it_stock_change = it_stock_change
      TABLES
           XMARC   = XMARC
           XMARD   = XMARD
           XMCH1   = XMCH1
           XMCHA   = XMCHA
           XMCHB   = XMCHB
           XMKOL   = XMKOL
           XMSKA   = XMSKA
           XMSKU   = XMSKU
           XMSLB   = XMSLB
           XMSPR   = XMSPR
           XMSSA   = XMSSA
           XMSSL   = XMSSL
           XMSSQ   = XMSSQ
      EXCEPTIONS
           OTHERS  = 1.


    ELSE.

*------------- Open FI Interface with foreign destination --------------
**ATC Check - security check
      TRY.
          lv_whitelist = fmtab-funct.
          INSERT lv_whitelist INTO TABLE lt_whitelist.
          fmtab-funct = cl_abap_dyn_prg=>check_whitelist_tab( val = fmtab-funct  whitelist = lt_whitelist ).
        CATCH cx_abap_not_in_whitelist.
          RETURN.
      ENDTRY.
***
      CALL FUNCTION FMTAB-FUNCT
        DESTINATION FMTAB-RFCDS
        EXPORTING
          BUDAT                 = BUDAT
          USNAM                 = USNAM
        TABLES
          XMARC                 = XMARC
          XMARD                 = XMARD
          XMCH1                 = XMCH1
          XMCHA                 = XMCHA
          XMCHB                 = XMCHB
          XMKOL                 = XMKOL
          XMSKA                 = XMSKA
          XMSKU                 = XMSKU
          XMSLB                 = XMSLB
          XMSPR                 = XMSPR
          XMSSA                 = XMSSA
          XMSSL                 = XMSSL
          XMSSQ                 = XMSSQ
        EXCEPTIONS
          COMMUNICATION_FAILURE = 1
          SYSTEM_FAILURE        = 2.
      IF SY-SUBRC NE 0.
        MESSAGE E011 WITH FMTAB-RFCDS.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDFUNCTION.