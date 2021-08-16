METHOD CONVERT.

*   The upgrade logger does not enrich log messages with timestamps. To allow at least high-level runtime analysis at customer side,
*   it is bets pratice to issue a log message with date and time information at the start and end of each logical data conversion phase.
  MESSAGE i035(upgba) WITH 'Starting to fill values' ' into table CLF_HDR. Client:' mv_client `Time: ` && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
  cl_upgba_logger=>log->trace_single( iv_flush = abap_true ).

  TRY.

    me->convert_core(
      EXPORTING
        iv_inputview_name = gc_clfhdrs_name
        iv_procpack_name  = 'PROCESS_PACKAGE_CS'
        iv_package_size   = 100000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        iv_inputview_name = gc_clfhdrm_name
        iv_procpack_name  = 'PROCESS_PACKAGE_CM'
        iv_package_size   = 100000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        iv_inputview_name = gc_kssks_name
        iv_procpack_name  = 'PROCESS_PACKAGE_S'
        iv_package_size   = 100000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        iv_inputview_name = gc_ksskm_name
        iv_procpack_name  = 'PROCESS_PACKAGE_M'
        iv_package_size   = 100000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        iv_inputview_name = gc_ksskk_name
        iv_procpack_name  = 'PROCESS_PACKAGE_K'
        iv_package_size   = 100000 ##NUMBER_OK
    ).

    " Let's see what events do we have as a summary.
    SORT mt_event_count BY event param.
    LOOP AT mt_event_count ASSIGNING FIELD-SYMBOL(<ls_event_count>).
      CASE <ls_event_count>-event.
        WHEN gc_ev_multicuobj.
          MESSAGE w011(ngc_core_db) WITH <ls_event_count>-count INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( ).
      ENDCASE.
    ENDLOOP.

    MESSAGE i035(upgba) WITH 'Filling values' ' into CLF_HDR finished. Client:' mv_client `Time: ` && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
    cl_upgba_logger=>log->trace_single( ).

  CATCH cx_shdb_pfw_exception INTO DATA(lx_shdb_pfw_exception).
    cl_upgba_logger=>log->error( ix_root = lx_shdb_pfw_exception  iv_incl_srcpos = abap_true ).
  CATCH cx_shdb_pfw_appl_error ##no_handler.
    " cannot be thrown as parallelization framework is not used for processing
  ENDTRY.

ENDMETHOD.