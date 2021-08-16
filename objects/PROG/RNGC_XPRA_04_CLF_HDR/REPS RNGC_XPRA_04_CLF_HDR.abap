*&---------------------------------------------------------------------*
*& Report RNGC_XPRA_04_CLF_HDR
*&---------------------------------------------------------------------*
*& Cloud introduction: 1905  On-premise introduction: -
*&---------------------------------------------------------------------*
REPORT RNGC_XPRA_04_CLF_HDR.

  CONSTANTS:
    gc_allclients    TYPE mandt VALUE '',
    gc_appl_name     TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

  DATA:
    lv_exit          TYPE boole_d ##NEEDED,
    lo_clf_hdr       TYPE REF TO cl_ngc_core_xpra_clf_hdr ##NEEDED.

  PARAMETERS:
    client           TYPE mandt DEFAULT gc_allclients.

INITIALIZATION.

  cl_ngc_core_data_conv=>init_logger( gc_appl_name ).

START-OF-SELECTION.

  " XPRAs must log at least a single message under all conditions (execution skipped, error, success, no data found for processing, ...).
  " No message is interpreted as cancelled program (RABAX) and therefore causes the system upgrade to stop!

  " do some pre-checks before the conversion
  lv_exit = cl_ngc_core_xpra_clf_hdr=>before_conversion( iv_client = client ).
  IF ( lv_exit = abap_true ).
    RETURN.
  ENDIF.

  " start conversion per client
  IF client EQ gc_allclients.
    LOOP AT cl_plm_xpra_utilities=>get_clients( ) ASSIGNING FIELD-SYMBOL(<ls_mandt>) ##NEEDED.
      lo_clf_hdr = NEW #( iv_appl_name = gc_appl_name iv_client = <ls_mandt>-mandt ).
      lo_clf_hdr->convert( ).
    ENDLOOP.
  ELSE.
    lo_clf_hdr = NEW #( iv_appl_name = gc_appl_name iv_client = client ).
    lo_clf_hdr->convert( ).
  ENDIF.

" finish conversion
cl_ngc_core_xpra_clf_hdr=>after_conversion( ).