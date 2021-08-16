METHOD after_package.

  " Summarize the events coming from the parallel threads:
  LOOP AT it_events ASSIGNING FIELD-SYMBOL(<is_event>).
    READ TABLE mt_event_count ASSIGNING FIELD-SYMBOL(<ms_event>) WITH TABLE KEY event = <is_event>-event param = <is_event>-param.
    IF sy-subrc EQ 0.
      IF <is_event>-event NE gc_ev_obj_chk_nexist.
        ADD <is_event>-count TO <ms_event>-count.
      ENDIF.
    ELSE.
      APPEND <is_event> TO mt_event_count.
    ENDIF.
  ENDLOOP.

  DATA(lv_pid) = cl_shdb_pfw=>ms_process_data-process_counter.

  MESSAGE i025(upgba) WITH lv_pid INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

  cl_upgba_logger=>log->trace_process_messages( lv_pid ).

  MESSAGE i026(upgba) WITH lv_pid INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

ENDMETHOD.