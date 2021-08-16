  METHOD if_ngc_core_conv_logger~log_error.

    cl_upgba_logger=>log->error(
      ix_root        = ix_root
      iv_incl_srcpos = abap_true
    ).

  ENDMETHOD.