METHOD after_conversion.

  " Delete our temporary views.
  me->delete_views( ).

  " log message
  MESSAGE i034(upgba) WITH 'Cleanup of table INOB finished. Client:' mv_client 'Time: ' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT .
  cl_upgba_logger=>log->trace_single( ).

ENDMETHOD.