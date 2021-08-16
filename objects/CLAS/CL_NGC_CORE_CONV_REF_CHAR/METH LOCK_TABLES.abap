METHOD lock_tables.

  DATA:
    lv_varkey  TYPE rstable-varkey,
    lt_tabname TYPE STANDARD TABLE OF rstable-tabname.

  rv_error   = abap_false.
  lv_varkey  = sy-mandt.
  lt_tabname = VALUE #( ( 'AUSP' ) ( 'TCLAO' ) ( 'TCLT' ) ).

  LOOP AT lt_tabname ASSIGNING FIELD-SYMBOL(<ls_tabname>).
    CALL FUNCTION 'ENQUEUE_E_TABLE'
      EXPORTING
        tabname        = <ls_tabname>
        varkey         = lv_varkey
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.

    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 1.
          MESSAGE e006(ngc_core_db) WITH <ls_tabname> INTO cl_upgba_logger=>mv_logmsg.
        WHEN 2 OR
             3.
          MESSAGE e007(ngc_core_db) WITH <ls_tabname> INTO cl_upgba_logger=>mv_logmsg.
      ENDCASE.
      cl_upgba_logger=>log->trace_single( ).
      unlock_tables( ).
      rv_error = abap_true.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.