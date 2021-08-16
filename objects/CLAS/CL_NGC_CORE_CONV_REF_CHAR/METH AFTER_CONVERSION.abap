METHOD after_conversion.

  " Delete our temporary views.
  me->delete_views( ).

  " Close log (and display in dialog mode).
  cl_upgba_logger=>log->close( ).

ENDMETHOD.