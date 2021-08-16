METHOD after_package.

  DATA(lv_pid) = cl_shdb_pfw=>ms_process_data-process_counter.

  MESSAGE i025(upgba) WITH lv_pid INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

  cl_upgba_logger=>log->trace_process_messages( lv_pid ).

  MESSAGE i026(upgba) WITH lv_pid INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

ENDMETHOD.