FUNCTION OUTBOUND_CALL_01000106_E.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       TABLES
*"              IT_AFPO_BT STRUCTURE  AFPOB
*"              IT_RESB_BT STRUCTURE  RESBB
*"----------------------------------------------------------------------
  DATA: lt_fmtab LIKE fmrfc OCCURS 0 WITH HEADER LINE.

  CALL FUNCTION 'BF_FUNCTIONS_FIND'
       EXPORTING
            i_event       = '01000106'
       TABLES
            t_fmrfc       = lt_fmtab
       EXCEPTIONS
            nothing_found = 4
            OTHERS        = 8.

  CHECK sy-subrc = 0.

  LOOP AT lt_fmtab.
    CHECK NOT lt_fmtab-funct IS INITIAL.
    IF lt_fmtab-rfcds IS INITIAL.

*------------- Open FI Interface with local destination ----------------

      CALL FUNCTION lt_fmtab-funct
           TABLES
                it_afpo_bt = it_afpo_bt
                it_resb_bt = it_resb_bt
           EXCEPTIONS
                OTHERS        = 1.

    ELSE.

*------------- Open FI Interface with foreign destination --------------
      CALL FUNCTION lt_fmtab-funct
        DESTINATION lt_fmtab-rfcds
             TABLES
                  it_afpo_bt = it_afpo_bt
                  it_resb_bt = it_resb_bt
           EXCEPTIONS communication_failure = 1
                      system_failure        = 2.
      IF sy-subrc NE 0.
        MESSAGE e011 WITH lt_fmtab-rfcds.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.