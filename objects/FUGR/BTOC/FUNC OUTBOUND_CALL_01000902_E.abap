FUNCTION OUTBOUND_CALL_01000902_E.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  TABLES
*"      PCM_PCMHB_TAB_T STRUCTURE  PCMHB
*"      PCM_PCMPB_TAB_T STRUCTURE  PCMPB
*"----------------------------------------------------------------------
************************************************************************
********* NORMAL EVENT for Campaign ************************************
************************************************************************
  DATA: lt_whitelist TYPE string_hashed_table,
        lv_whitelist TYPE string.

  call function 'BF_FUNCTIONS_FIND'
       EXPORTING
            i_event       = '01000902'
       TABLES
            t_fmrfc       = fmtab
       EXCEPTIONS
            nothing_found = 4
            others        = 8.

  check sy-subrc = 0.
  loop at fmtab.

    check not fmtab-funct is initial.

    if fmtab-rfcds is initial.

*------------- Open Interface with local destination -------------------

      call function fmtab-funct
           TABLES
                pcm_pcmhb_tab_t = pcm_pcmhb_tab_t
                pcm_pcmpb_tab_t = pcm_pcmpb_tab_t.

    else.

*------------- Open Interface with foreign destination -----------------
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
           tables
                pcm_pcmhb_tab_t =   pcm_pcmhb_tab_t
                pcm_pcmpb_tab_t =   pcm_pcmpb_tab_t
      exceptions
           communication_failure = 1
           system_failure        = 2.
      if sy-subrc ne 0.
        message e011 with fmtab-rfcds.
      endif.
    endif.
  endloop.

ENDFUNCTION.