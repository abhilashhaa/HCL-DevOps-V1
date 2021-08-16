*&---------------------------------------------------------------------*
*& Report RNGC_XPRA_01_DATUB_KSML
*&---------------------------------------------------------------------*
*& Cloud introduction: 1708  On-premise introduction: 1709
*&---------------------------------------------------------------------*
REPORT rngc_xpra_01_datub_ksml.

  CONSTANTS:
    gc_allclients    TYPE mandt VALUE '',
    gc_appl_name     TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

  DATA:
    lv_exit          TYPE boole_d,
    lo_datub_ksml    TYPE REF TO cl_ngc_core_xpra_datub_ksml.

  PARAMETERS:
    client           TYPE mandt       DEFAULT gc_allclients,
    rework           TYPE boole_d     DEFAULT abap_false.

INITIALIZATION.

  cl_ngc_core_data_conv=>init_logger( gc_appl_name ).

START-OF-SELECTION.

  " XPRAs must log at least a single message under all conditions (execution skipped, error, success, no data found for processing, ...).
  " No message is interpreted as cancelled program (RABAX) and therefore causes the system upgrade to stop!

  " do some pre-checks before the conversion
  lv_exit = cl_ngc_core_xpra_datub_ksml=>before_conversion( iv_client = client  iv_rework = rework ).
  IF ( lv_exit = abap_true ).
    EXIT.
  ENDIF.

  " start conversion per client
  IF client EQ gc_allclients.
    LOOP AT cl_plm_xpra_utilities=>get_clients( ) ASSIGNING FIELD-SYMBOL(<ls_mandt>).
      lo_datub_ksml = NEW #( iv_appl_name = gc_appl_name  iv_client = <ls_mandt>-mandt  iv_rework = rework ).
      lo_datub_ksml->convert_client( ).
    ENDLOOP.
  ELSE.
    lo_datub_ksml = NEW #( iv_appl_name = gc_appl_name  iv_client = client  iv_rework = rework ).
    lo_datub_ksml->convert_client( ).
  ENDIF.

  " finish conversion
  cl_ngc_core_xpra_datub_ksml=>after_conversion( ).