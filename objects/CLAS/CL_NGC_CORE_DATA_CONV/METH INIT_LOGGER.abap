METHOD init_logger.

  "initialize the logger instance with logtype 'transport'
  cl_upgba_logger=>create( EXPORTING iv_logid    = iv_appl_name
                                     iv_logtype  = cl_upgba_logger=>gc_logtype_tr ).
  cl_upgba_logger=>log->cleanup( ).

ENDMETHOD.