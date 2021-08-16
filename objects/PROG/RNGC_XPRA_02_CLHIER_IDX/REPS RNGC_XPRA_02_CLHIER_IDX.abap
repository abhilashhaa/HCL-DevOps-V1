*&---------------------------------------------------------------------*
*& Report RNGC_XPRA_02_CLHIER_IDX
*&---------------------------------------------------------------------*
*& Cloud introduction: 1708  On-premise introduction: 1709
*&---------------------------------------------------------------------*
REPORT RNGC_XPRA_02_CLHIER_IDX.

  CONSTANTS:
    gc_allclients    TYPE mandt VALUE '',
    gc_appl_name     TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

  DATA:
    lv_exit          TYPE boole_d,
    lo_cls_hier      TYPE REF TO cl_ngc_core_xpra_cls_hier.

  PARAMETERS:
    client           TYPE mandt       DEFAULT gc_allclients.

INITIALIZATION.

  cl_ngc_core_data_conv=>init_logger( gc_appl_name ).

START-OF-SELECTION.

  " XPRAs must log at least a single message under all conditions (execution skipped, error, success, no data found for processing, ...).
  " No message is interpreted as cancelled program (RABAX) and therefore causes the system upgrade to stop!

  " do some pre-checks before the conversion
  lv_exit = cl_ngc_core_xpra_cls_hier=>before_conversion( ).
  IF ( lv_exit = abap_true ).
    EXIT.
  ENDIF.

  " start conversion per client
  IF client EQ gc_allclients.
    LOOP AT cl_plm_xpra_utilities=>get_clients( ) ASSIGNING FIELD-SYMBOL(<ls_mandt>).
      lo_cls_hier = NEW #( iv_appl_name = gc_appl_name  iv_client = <ls_mandt>-mandt  iv_rework = abap_false ).
      lo_cls_hier->convert_client( ).
    ENDLOOP.
  ELSE.
    lo_cls_hier = NEW #( iv_appl_name = gc_appl_name  iv_client = client  iv_rework = abap_false ).
    lo_cls_hier->convert_client( ).
  ENDIF.

  " finish conversion
  cl_ngc_core_xpra_cls_hier=>after_conversion( ).