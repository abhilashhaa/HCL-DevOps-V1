FUNCTION NGC_CORE_CONV_MULTOBJ.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CLASS_TYPE) TYPE  KLASSENART OPTIONAL
*"     REFERENCE(IV_CUSTOMIZING_HANDLING) TYPE  I DEFAULT 0
*"  EXPORTING
*"     REFERENCE(ET_MESSAGE) TYPE  SYMSG_TAB
*"----------------------------------------------------------------------

  CONSTANTS:
    gc_appl_name     TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

  DATA:
    lv_exit          TYPE boole_d,
    lo_multobj       TYPE REF TO cl_ngc_core_conv_multobj.

  CLEAR: et_message.

  cl_ngc_core_conv_multobj=>init_logger( iv_appl_name = gc_appl_name   iv_logtype = cl_upgba_logger=>gc_logtype_db ).

  " We must log at least a single message under all conditions (execution skipped, error, success, no data found for processing, ...).
  " No message is interpreted as cancelled program (RABAX) and therefore causes the system upgrade to stop!

  lo_multobj = NEW #( iv_appl_name = gc_appl_name  iv_class_type = iv_class_type  iv_customizing_handling = iv_customizing_handling ).

  " do some pre-checks before the conversion
  lv_exit = lo_multobj->before_conversion( ).
  IF ( lv_exit = abap_false ).
    " start conversion in the current client
    lo_multobj->convert( ).
    " finish conversion
    lo_multobj->after_conversion( ).
  ENDIF.

  DATA(lt_logs) = cl_upgba_logger=>log->get_log_messages( iv_logid =  gc_appl_name ).
  MOVE-CORRESPONDING lt_logs TO et_message.

  " close log
  IF cl_upgba_logger=>log IS BOUND.
    cl_upgba_logger=>log->close( ).
  ENDIF.
ENDFUNCTION.