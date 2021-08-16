  METHOD after_package.

    " Summarize the events coming from the parallel threads.
    LOOP AT it_events REFERENCE INTO DATA(ir_event).
      ASSIGN mt_event_count[ event = ir_event->event param = ir_event->param ] TO FIELD-SYMBOL(<ms_event>).

      IF sy-subrc IS INITIAL.
        IF ir_event->event <> gc_ev_obj_chk_nexist.
          <ms_event>-count += ir_event->count.
        ENDIF.
      ELSE.
        APPEND ir_event->* TO mt_event_count.
      ENDIF.
    ENDLOOP.

    DATA(lv_pid) = cl_shdb_pfw=>ms_process_data-process_counter.

    mo_conv_logger->log_message(
      iv_id     = 'UPGBA'
      iv_type   = 'I'
      iv_number = '025'
      iv_param1 = CONV #( lv_pid )
    ) ##NO_TEXT.

    mo_conv_logger->trace_process_messages( lv_pid ).

    mo_conv_logger->log_message(
      iv_id     = 'UPGBA'
      iv_type   = 'I'
      iv_number = '026'
      iv_param1 = CONV #( lv_pid )
    ) ##NO_TEXT.

  ENDMETHOD.