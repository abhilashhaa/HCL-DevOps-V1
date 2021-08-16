FUNCTION SAMPLE_PROCESS_00503122.
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





ENDFUNCTION.