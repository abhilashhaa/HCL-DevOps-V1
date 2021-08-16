FUNCTION outbound_call_01000011_e.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  TABLES
*"      XMSEG STRUCTURE  MSEG
*"      /SPE/PLANTRIGGER_TIMESTAMP STRUCTURE
*"        /SPE/PLANTRIGGER_AFS_TIMESTAMP OPTIONAL
*"----------------------------------------------------------------------

************************************************************************

********* SAMPLE FOR NORMAL EVENT WITHOUT EXPORT TO MEMORY *************

************************************************************************
  DATA: lt_fmrfc TYPE TABLE OF fmrfc,
        lt_whitelist TYPE string_hashed_table,
        lv_whitelist TYPE string.

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
    EXPORTING
      i_event       = '01000011'
    TABLES
      t_fmrfc       = fmtab
    EXCEPTIONS
      nothing_found = 4
      OTHERS        = 8.

  INSERT LINES OF fmtab INTO TABLE lt_fmrfc.
  CLEAR fmtab[].
***Add CRMS4 logistic related FMs.
  CALL METHOD cl_crms4_ndi_manager=>enrich_logistic_functions
    EXPORTING
      iv_event = '01000011'
    CHANGING
      ct_fmtab = lt_fmrfc.
  INSERT LINES OF lt_fmrfc INTO TABLE fmtab.

  CHECK fmtab[] IS NOT INITIAL.

  LOOP AT fmtab.
    CHECK NOT fmtab-funct IS INITIAL.
    IF fmtab-rfcds IS INITIAL.

*------------- Open FI Interface with local destination ----------------
      CALL FUNCTION fmtab-funct
        TABLES
          xmseg                      = xmseg
* New table for Timestamps and Planning Trigger
          /spe/plantrigger_timestamp = /spe/plantrigger_timestamp
        EXCEPTIONS
          OTHERS                     = 1.

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
      CALL FUNCTION fmtab-funct
        DESTINATION fmtab-rfcds
        TABLES
          xmseg                      = xmseg
* New table for Timestamps and Planning Trigger
          /spe/plantrigger_timestamp = /spe/plantrigger_timestamp
        EXCEPTIONS
          communication_failure      = 1
          system_failure             = 2.
      IF sy-subrc NE 0.
        MESSAGE e011 WITH fmtab-rfcds.
      ENDIF.
    ENDIF.
  ENDLOOP.




ENDFUNCTION.