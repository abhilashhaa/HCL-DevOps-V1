METHOD after_conversion.

  " close log (and display in dialog mode)
  MESSAGE i034(upgba) WITH 'Update finished for DATUB in CABN, Time: ' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).
  cl_upgba_logger=>log->close( ).

ENDMETHOD.