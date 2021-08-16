METHOD convert.

  IF mv_rework EQ abap_true.
    " rework = true -> this is not system downtime
    " Lock all tables about to write
    DATA(lv_lock_error) = me->lock_tables( ).
    IF lv_lock_error = abap_true.
      RETURN.
    ENDIF.
  ENDIF.

*   The upgrade logger does not enrich log messages with timestamps. To allow at least high-level runtime analysis at customer side,
*   it is bets pratice to issue a log message with date and time information at the start and end of each logical data conversion phase.
  MESSAGE i035(upgba) WITH 'Starting to copy Reference Characteristic values' ' into AUSP. Client:' sy-mandt 'Time: ' && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
  cl_upgba_logger=>log->trace_single( ).

  TRY.

    DATA(lv_in_range_limit) = me->determine_in_range_limit( ).
    mv_1_cond_p_line_limit  = 16000. " me->determine_dyn_where_limit( ).
    mv_2_cond_p_line_limit  = mv_1_cond_p_line_limit / 2.
    mv_3_cond_p_line_limit  = mv_1_cond_p_line_limit / 3.

    DATA(lo_msg) = NEW cl_shdb_pfw_logging( ir_logger = cl_upgba_logger=>log ).

    me->convert_core(
      EXPORTING
        io_logger        = lo_msg
        io_refval_reader = NEW lcl_refval_reader_general( iv_language = mv_language  iv_in_range_limit = lv_in_range_limit )
        iv_package_size  = 20000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        io_logger        = lo_msg
        io_refval_reader = NEW lcl_refval_reader_mara( iv_language = mv_language  iv_in_range_limit = lv_in_range_limit )
        iv_package_size  = 100000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        io_logger        = lo_msg
        io_refval_reader = NEW lcl_refval_reader_mcha( iv_language = mv_language  iv_in_range_limit = lv_in_range_limit )
        iv_package_size  = 100000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        io_logger        = lo_msg
        io_refval_reader = NEW lcl_refval_reader_mch1( iv_language = mv_language  iv_in_range_limit = lv_in_range_limit )
        iv_package_size  = 100000 ##NUMBER_OK
    ).
    me->convert_core(
      EXPORTING
        io_logger        = lo_msg
        io_refval_reader = NEW lcl_refval_reader_draw( iv_language = mv_language  iv_in_range_limit = lv_in_range_limit )
        iv_package_size  = 100000 ##NUMBER_OK
    ).

    " Let's see what events do we have as a summary.
    SORT mt_event_count BY event param.
    LOOP AT mt_event_count ASSIGNING FIELD-SYMBOL(<ls_event_count>).
      CASE <ls_event_count>-event.
        WHEN gc_ev_obj_chk_nexist.
          MESSAGE w000(ngc_core_db) WITH <ls_event_count>-param INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( iv_severity = 'P' ).
        WHEN gc_ev_bo_nexist.
          MESSAGE w001(ngc_core_db) WITH <ls_event_count>-count INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( iv_severity = 'P' ).
        WHEN gc_ev_bo_flock.
          MESSAGE w002(ngc_core_db) WITH <ls_event_count>-count INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( iv_severity = 'P' ).
        WHEN gc_ev_bo_sysfail.
          MESSAGE e003(ngc_core_db) WITH <ls_event_count>-count INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( ).
        WHEN gc_ev_bo_errmsg.
          MESSAGE w004(ngc_core_db) WITH <ls_event_count>-count INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( iv_severity = 'P' ).
        WHEN gc_ev_type_conv_fail.
          MESSAGE w005(ngc_core_db) WITH <ls_event_count>-count INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( iv_severity = 'P' ).
      ENDCASE.
    ENDLOOP.

    MESSAGE i035(upgba) WITH 'Copying Reference Characteristic values' ' into AUSP finished. Client:' sy-mandt 'Time: ' && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
    cl_upgba_logger=>log->trace_single( ).

    me->update_redun( ).
    MESSAGE i035(upgba) WITH 'Updating REDUN flags in TCLAO finished. Client:' sy-mandt 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
    cl_upgba_logger=>log->trace_single( ).

  CATCH cx_shdb_pfw_exception INTO DATA(lx_shdb_pfw_exception).
    cl_upgba_logger=>log->error( ix_root = lx_shdb_pfw_exception  iv_incl_srcpos = abap_true ).
  ENDTRY.

  IF mv_rework EQ abap_true.
    " rework = true -> this is not system downtime.
    " Unlock all tables about to write.
    me->unlock_tables( ).
  ENDIF.

ENDMETHOD.