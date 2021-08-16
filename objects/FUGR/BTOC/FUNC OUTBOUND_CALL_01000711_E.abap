FUNCTION OUTBOUND_CALL_01000711_E.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IM_MATNR) LIKE  EBAN-MATNR
*"     REFERENCE(IM_WERKS) LIKE  EBAN-WERKS
*"  EXPORTING
*"     REFERENCE(EX_APO_ACTIVE) TYPE  XFELD
*"----------------------------------------------------------------------

  DATA: lt_whitelist TYPE string_hashed_table,
        lv_whitelist TYPE string.
  CALL FUNCTION 'BF_FUNCTIONS_FIND'
       EXPORTING
            I_EVENT       = '01000711'
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
                I_MATNR      = IM_MATNR
                I_WERKS      = IM_WERKS
           IMPORTING
                EX_APO_ACTIVE = EX_APO_ACTIVE
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
                I_MATNR      = IM_MATNR
                I_WERKS      = IM_WERKS
           IMPORTING
                EX_APO_ACTIVE = EX_APO_ACTIVE
           EXCEPTIONS COMMUNICATION_FAILURE = 1
                      SYSTEM_FAILURE        = 2.
      IF SY-SUBRC NE 0.
        MESSAGE E011 WITH FMTAB-RFCDS.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.