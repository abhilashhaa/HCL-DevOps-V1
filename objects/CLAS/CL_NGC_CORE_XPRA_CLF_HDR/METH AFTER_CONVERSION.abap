METHOD AFTER_CONVERSION.

  " Delete our temporary views.
  cl_ngc_core_xpra_clf_hdr=>delete_views( ).

  " Close log (and display in dialog mode).
  TEST-SEAM log_close_3_seam.
    cl_upgba_logger=>log->close( ).
  END-TEST-SEAM.

ENDMETHOD.