function outbound_call_01000791_e.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TRGUID) TYPE  CS_GUIDC OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_whitelist TYPE string_hashed_table,
        lv_whitelist TYPE string.
  call function 'BF_FUNCTIONS_FIND'
       exporting
            i_event       = '01000791'
       tables
            t_fmrfc       = fmtab
       exceptions
            nothing_found = 4
            others        = 8.
  check sy-subrc = 0.
  loop at fmtab.
    check not fmtab-funct is initial.
    if fmtab-rfcds is initial.

*------------- Open FI Interface with local destination ----------------
      call function fmtab-funct
           exporting
                i_trguid = i_trguid
           exceptions
                others   = 1.
    else.

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

      call function fmtab-funct
        destination fmtab-rfcds
           exporting
                i_trguid  = i_trguid
           exceptions communication_failure = 1
                      system_failure        = 2.
      if sy-subrc ne 0.
        message e011 with fmtab-rfcds.
      endif.
    endif.
  endloop.

endfunction.