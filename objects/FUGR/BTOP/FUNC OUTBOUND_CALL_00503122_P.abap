FUNCTION outbound_call_00503122_p.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_VBELN) LIKE  VBAK-VBELN
*"     VALUE(IV_POSNR) LIKE  VBAP-POSNR
*"     VALUE(IV_SELLING_COMPANY_CODE) TYPE  C
*"     VALUE(IV_MEINS) LIKE  VBAP-MEINS OPTIONAL
*"     VALUE(IV_GJAHR) LIKE  COBL-GJAHR OPTIONAL
*"  EXPORTING
*"     REFERENCE(ES_COBL) LIKE  COBL STRUCTURE  COBL
*"  EXCEPTIONS
*"      NOT_IAOM_RELEVANT
*"      ERROR_OCCURRED
*"----------------------------------------------------------------------

  CALL FUNCTION 'PC_FUNCTION_FIND'
    EXPORTING
      i_procs       = '00503122'
    TABLES
      t_fmrfc       = fmtab
    EXCEPTIONS
      nothing_found = 4
      OTHERS        = 8.

  IF sy-subrc EQ 4.
    RAISE not_iaom_relevant.
  ENDIF.

  CHECK sy-subrc = 0.

  LOOP AT fmtab.

    CHECK NOT fmtab-funct IS INITIAL.

    IF fmtab-rfcds IS INITIAL.

      CALL FUNCTION fmtab-funct
        EXPORTING
          iv_vbeln                = iv_vbeln
          iv_posnr                = iv_posnr
          iv_selling_company_code = iv_selling_company_code
          iv_meins                = iv_meins
          iv_gjahr                = iv_gjahr
        IMPORTING
          es_cobl                 = es_cobl
        EXCEPTIONS
          not_iaom_relevant       = 1
          error_occurred          = 2
          OTHERS                  = 3.

      IF sy-subrc EQ 1.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                RAISING not_iaom_relevant.
      ELSEIF sy-subrc > 1.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                RAISING error_occurred.
      ENDIF.

    ELSE.
      CALL FUNCTION fmtab-funct
        DESTINATION fmtab-rfcds
        EXPORTING
          iv_vbeln                = iv_vbeln
          iv_posnr                = iv_posnr
          iv_selling_company_code = iv_selling_company_code
          iv_meins                = iv_meins
          iv_gjahr                = iv_gjahr
        IMPORTING
          es_cobl                 = es_cobl
        EXCEPTIONS
          not_iaom_relevant       = 1
          error_occurred          = 2
          OTHERS                  = 3.

      IF sy-subrc NE 0.
        MESSAGE e011 WITH fmtab-rfcds.
      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFUNCTION.