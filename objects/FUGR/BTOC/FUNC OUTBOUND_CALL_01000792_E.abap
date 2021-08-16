FUNCTION outbound_call_01000792_e.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(PI_BUFFER_REFRESH) TYPE  XFELD DEFAULT ' '
*"  TABLES
*"      IT_POSGUID STRUCTURE  MEPO_POSGUID OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_whitelist TYPE string_hashed_table,
        lv_whitelist TYPE string.

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
    EXPORTING
      i_event       = '01000792'
    TABLES
      t_fmrfc       = fmtab
    EXCEPTIONS
      nothing_found = 4
      OTHERS        = 8.
  CHECK sy-subrc = 0.
  LOOP AT fmtab.
    CHECK NOT fmtab-funct IS INITIAL.
    IF fmtab-rfcds IS INITIAL.

*------------- Open FI Interface with local destination ----------------
      CALL FUNCTION fmtab-funct
        EXPORTING
          pi_buffer_refresh = pi_buffer_refresh
        TABLES
          it_posguid        = it_posguid
        EXCEPTIONS
          OTHERS            = 1.
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
        EXPORTING
          pi_buffer_refresh     = pi_buffer_refresh
        TABLES
          it_posguid            = it_posguid
        EXCEPTIONS
          communication_failure = 1
          system_failure        = 2.
      IF sy-subrc NE 0.
        MESSAGE e011 WITH fmtab-rfcds.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.