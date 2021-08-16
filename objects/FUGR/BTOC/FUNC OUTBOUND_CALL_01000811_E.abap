FUNCTION outbound_call_01000811_e.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_APOINF) LIKE  SHP_APOINF STRUCTURE  SHP_APOINF OPTIONAL
*"  TABLES
*"      IT_SL_DOC STRUCTURE  SLDOC_ATP
*"      IT_SL_REQ STRUCTURE  SLREQ_ATP
*"      IT_SL_GID STRUCTURE  SLGID_ATP
*"      IT_SL_DOC_X STRUCTURE  SLDOCX_ATP
*"      IT_SL_REQ_X STRUCTURE  SLREQX_ATP
*"      IT_ATPFIELD STRUCTURE  ATPFIELD
*"      IT_QUOT_VB STRUCTURE  QUOT_VBAPO
*"      IT_COCLST STRUCTURE  SLCOCLST OPTIONAL
*"      IT_SD_MON_ITM STRUCTURE  SLMON_ITM_CIF OPTIONAL
*"      IT_SD_MON_SCH STRUCTURE  SLMON_SCH_CIF OPTIONAL
*"----------------------------------------------------------------------

  DATA: fmtab LIKE fmrfc OCCURS 0 WITH HEADER LINE.

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
    EXPORTING
      i_event       = '01000811'
    TABLES
      t_fmrfc       = fmtab
    EXCEPTIONS
      nothing_found = 4
      OTHERS        = 8.

  CHECK sy-subrc = 0.

  LOOP AT fmtab.
    CHECK NOT fmtab-funct IS INITIAL.
    IF fmtab-rfcds IS INITIAL.

ENHANCEMENT-SECTION     EHP_OUTBOUND_CALL_01000811_E_1 SPOTS ES_SAPLBTOC.
      CALL FUNCTION fmtab-funct
        EXPORTING
          is_apoinf     = is_apoinf
        TABLES
          it_sl_doc     = it_sl_doc
          it_sl_req     = it_sl_req
          it_sl_gid     = it_sl_gid
          it_sl_doc_x   = it_sl_doc_x
          it_sl_req_x   = it_sl_req_x
          it_atpfield   = it_atpfield
          it_quot_vb    = it_quot_vb
          it_coclst     = it_coclst
        EXCEPTIONS
          OTHERS        = 1.
END-ENHANCEMENT-SECTION.

    ELSE.
ENHANCEMENT-SECTION     EHP_OUTBOUND_CALL_01000811_E_2 SPOTS ES_SAPLBTOC.
      CALL FUNCTION fmtab-funct
        DESTINATION fmtab-rfcds
        EXPORTING
          is_apoinf     = is_apoinf
        TABLES
          it_sl_doc     = it_sl_doc
          it_sl_req     = it_sl_req
          it_sl_gid     = it_sl_gid
          it_sl_doc_x   = it_sl_doc_x
          it_sl_req_x   = it_sl_req_x
          it_atpfield   = it_atpfield
          it_quot_vb    = it_quot_vb
          it_coclst     = it_coclst
        EXCEPTIONS
          OTHERS        = 1.
END-ENHANCEMENT-SECTION.
    ENDIF.
  ENDLOOP.




ENDFUNCTION.