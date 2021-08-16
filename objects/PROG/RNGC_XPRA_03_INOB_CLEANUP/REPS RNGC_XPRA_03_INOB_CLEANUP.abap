*&---------------------------------------------------------------------*
*& Report RNGC_XPRA_03_INOB_CLEANUP
*&---------------------------------------------------------------------*
*& Cloud introduction: 1905  On-premise introduction: 1709 SPS4
*&---------------------------------------------------------------------*
REPORT rngc_xpra_03_inob_cleanup.

CONSTANTS:
  gc_allclients TYPE mandt VALUE '',
  gc_appl_name  TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

PARAMETERS:
  client TYPE mandt DEFAULT gc_allclients.

INITIALIZATION.

  cl_ngc_core_data_conv=>init_logger( gc_appl_name ).

START-OF-SELECTION.

  " XPRAs must log at least a single message under all conditions (execution skipped, error, success, no data found for processing, ...).
  " No message is interpreted as cancelled program (RABAX) and therefore causes the system upgrade to stop!

  IF client EQ gc_allclients.
    LOOP AT cl_plm_xpra_utilities=>get_clients( ) ASSIGNING FIELD-SYMBOL(<ls_mandt>).
      DATA(lo_inob_cleanup) = NEW cl_ngc_core_xpra_inob_cleanup( iv_appl_name = gc_appl_name iv_client = <ls_mandt>-mandt ).
      " do some pre-checks before the conversion
      DATA(lv_exit) = lo_inob_cleanup->before_conversion( ).
      IF ( lv_exit = abap_false ).
        " start conversion per client
        lo_inob_cleanup->convert( ).
        " finish conversion
        lo_inob_cleanup->after_conversion( ).
      ENDIF.
    ENDLOOP.
  ELSE.
    lo_inob_cleanup = NEW #( iv_appl_name = gc_appl_name iv_client = client ).
    " do some pre-checks before the conversion
    lv_exit = lo_inob_cleanup->before_conversion( ).
    IF ( lv_exit = abap_false ).
      " start conversion per client
      lo_inob_cleanup->convert( ).
      " finish conversion
      lo_inob_cleanup->after_conversion( ).
    ENDIF.
  ENDIF.

  cl_upgba_logger=>log->close( ).
  RETURN.