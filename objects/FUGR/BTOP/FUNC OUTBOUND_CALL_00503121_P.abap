FUNCTION outbound_call_00503121_p.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VBAK) LIKE  VBAK STRUCTURE  VBAK
*"     VALUE(I_VBAP) LIKE  VBAP STRUCTURE  VBAP
*"     VALUE(I_LIPS) LIKE  LIPS STRUCTURE  LIPS OPTIONAL
*"     VALUE(I_LIKP) LIKE  LIKP STRUCTURE  LIKP OPTIONAL
*"     VALUE(I_VBRP) LIKE  VBRP STRUCTURE  VBRP OPTIONAL
*"     VALUE(I_VBRK) LIKE  VBRK STRUCTURE  VBRK OPTIONAL
*"  EXPORTING
*"     REFERENCE(E_VBAP) LIKE  VBAP STRUCTURE  VBAP
*"  EXCEPTIONS
*"      OBJECT_UNKNOWN
*"      ERROR_OCCURRED
*"----------------------------------------------------------------------


  CALL FUNCTION 'PC_FUNCTION_FIND'
    EXPORTING
      i_procs       = '00503121'
    TABLES
      t_fmrfc       = fmtab
    EXCEPTIONS
      nothing_found = 4
      OTHERS        = 8.

  CHECK sy-subrc = 0.

  LOOP AT fmtab.

    CHECK NOT fmtab-funct IS INITIAL.

    IF fmtab-rfcds IS INITIAL.

      CALL FUNCTION fmtab-funct
        EXPORTING
          i_vbak         = i_vbak
          i_vbap         = i_vbap
          i_lips         = i_lips
          i_likp         = i_likp
          i_vbrp         = i_vbrp
          i_vbrk         = i_vbrk
        IMPORTING
          e_vbap         = e_vbap
        EXCEPTIONS
          object_unknown = 1
          error_occurred = 2
          OTHERS         = 3.

      IF sy-subrc EQ 1.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                RAISING object_unknown.
      ELSEIF sy-subrc > 1.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                RAISING error_occurred.
      ENDIF.

    ELSE.
      CALL FUNCTION fmtab-funct DESTINATION fmtab-rfcds
        EXPORTING
          i_vbak         = i_vbak
          i_vbap         = i_vbap
          i_lips         = i_lips
          i_likp         = i_likp
          i_vbrp         = i_vbrp
          i_vbrk         = i_vbrk
        IMPORTING
          e_vbap         = e_vbap
        EXCEPTIONS
          object_unknown = 1
          error_occurred = 2
          OTHERS         = 3.

      IF sy-subrc NE 0.
        MESSAGE e011 WITH fmtab-rfcds RAISING error_occurred.
      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFUNCTION.