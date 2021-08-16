FUNCTION OUTBOUND_CALL_01000601_E.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  TABLES
*"      XPBABX STRUCTURE  PBABX
*"----------------------------------------------------------------------
  DATA: lt_whitelist TYPE string_hashed_table,
        lv_whitelist TYPE string.

*------------- find function name for call function reduce demand

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
       EXPORTING
            I_EVENT       = '01000601'
       TABLES
            T_FMRFC       = FMTAB
       EXCEPTIONS
            NOTHING_FOUND = 4
            OTHERS        = 8.
  CHECK SY-SUBRC = 0.
  LOOP AT FMTAB.
    CHECK NOT FMTAB-FUNCT IS INITIAL.
    IF FMTAB-RFCDS IS INITIAL.

*------------- Interface with local destination ----------------
      CALL FUNCTION FMTAB-FUNCT
      TABLES
        XPBABX = XPBABX.
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
        TABLES
          XPBABX = XPBABX.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.