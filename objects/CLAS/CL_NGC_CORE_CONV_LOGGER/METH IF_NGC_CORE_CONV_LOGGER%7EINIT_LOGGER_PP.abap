  METHOD if_ngc_core_conv_logger~init_logger_pp.

    cl_upgba_logger=>create(
      iv_logid     = iv_appl_name
      iv_logtype   = cl_upgba_logger=>gc_logtype_db
      iv_processid = cl_shdb_pfw=>ms_process_data-process_counter
      iv_skip_init = abap_true
    ).

  ENDMETHOD.