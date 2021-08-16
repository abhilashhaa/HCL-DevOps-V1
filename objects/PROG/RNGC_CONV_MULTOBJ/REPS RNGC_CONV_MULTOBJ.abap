*&---------------------------------------------------------------------*
*& Report RNGC_CONV_MULTOBJ
*&---------------------------------------------------------------------*
*& Cloud introduction: 1802  On-premise introduction: none
*&---------------------------------------------------------------------*
REPORT rngc_conv_multobj.

  CONSTANTS:
    gc_appl_name     TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

  DATA:
    lv_exit          TYPE boole_d,
    lo_multobj       TYPE REF TO cl_ngc_core_conv_multobj.

  PARAMETERS:
    cls_type         TYPE klassenart DEFAULT ''.

INITIALIZATION.

  cl_ngc_core_conv_multobj=>init_logger( gc_appl_name ).

START-OF-SELECTION.

  " We must log at least a single message under all conditions (execution skipped, error, success, no data found for processing, ...).
  " No message is interpreted as cancelled program (RABAX) and therefore causes the system upgrade to stop!

  lo_multobj = NEW #( iv_appl_name = gc_appl_name  iv_class_type = cls_type  iv_customizing_handling = 0 ).

  " do some pre-checks before the conversion
  lv_exit = lo_multobj->before_conversion( ).
  IF ( lv_exit = abap_false ).
    " start conversion in the current client
    lo_multobj->convert( ).
    " finish conversion
    lo_multobj->after_conversion( ).
  ENDIF.

  " close log (and display in dialog mode)
  IF cl_upgba_logger=>log IS BOUND.
    cl_upgba_logger=>log->close( ).
  ENDIF.