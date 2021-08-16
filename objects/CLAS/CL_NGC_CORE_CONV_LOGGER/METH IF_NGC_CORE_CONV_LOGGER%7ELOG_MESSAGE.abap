  METHOD if_ngc_core_conv_logger~log_message.

    MESSAGE ID iv_id TYPE iv_type NUMBER iv_number WITH iv_param1 iv_param2 iv_param3 iv_param4 INTO cl_upgba_logger=>mv_logmsg.

    IF iv_severity IS SUPPLIED.
      cl_upgba_logger=>log->trace_single( iv_severity = iv_severity ).
    ELSE.
      cl_upgba_logger=>log->trace_single( ).
    ENDIF.

  ENDMETHOD.