METHOD update_multobj.
  DATA:
    lv_tab       TYPE string.

  MESSAGE i035(upgba) WITH 'Update/Insert of TCLA, TCLAO, TCLAX started. Client:' sy-mandt 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

  TRY.
    lv_tab = 'TCLAO'.
    MODIFY tclao FROM TABLE mt_tclao.
    lv_tab = 'TCLAX'.
    MODIFY tclax FROM TABLE mt_tclax.
  CATCH cx_root.
    CALL FUNCTION 'DB_ROLLBACK'.
    RAISE EXCEPTION TYPE cx_data_conv_error
      MESSAGE ID 'UPGBA'
      TYPE 'E'
      NUMBER '034'
      WITH 'INSERT (MODIFY) into' lv_tab 'failed!'.
  ENDTRY.

  TRY.
    IF mv_class_type EQ ''.
      UPDATE tcla SET multobj = 'X' WHERE multobj = ' ' AND klart <> '230' AND klart <> '102'.
    ELSE.
      UPDATE tcla SET multobj = 'X' WHERE klart = mv_class_type AND multobj = ' '.
    ENDIF.
  CATCH cx_root.
    CALL FUNCTION 'DB_ROLLBACK'.
    RAISE EXCEPTION TYPE cx_data_conv_error
      MESSAGE ID 'UPGBA'
      TYPE 'E'
      NUMBER '034'
      WITH 'UPDATE' 'TCLA' 'failed!'.
  ENDTRY.

  MESSAGE i035(upgba) WITH 'Update/Insert of TCLA, TCLAO, TCLAX ended. Client:' sy-mandt 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

  CALL FUNCTION 'DB_COMMIT'.
ENDMETHOD.