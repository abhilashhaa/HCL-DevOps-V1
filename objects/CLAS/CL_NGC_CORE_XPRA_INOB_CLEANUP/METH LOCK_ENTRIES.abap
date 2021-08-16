METHOD lock_entries.

  DATA:
    lt_inob TYPE STANDARD TABLE OF inob.

  rv_lock_error = abap_false.

  IF itr_cuobj IS INITIAL.
    RETURN.
  ENDIF.

  " collect relevant INOB entries so that we can try to set lock for KSSK
  SELECT mandt, klart, objek FROM inob CLIENT SPECIFIED INTO CORRESPONDING FIELDS OF TABLE @lt_inob
    WHERE mandt = @mv_client
      AND cuobj IN @itr_cuobj ##TOO_MANY_ITAB_FIELDS.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  " process objects with locking to KSSK
  " if this locking fails, it means that the object with this class type is
  " currently being processed by someone else, therefore we cannot delete the
  " INOB entry.
  " (Classification reuses INOB entry, if there is only INOB entry without KSSK, AUSP)
  LOOP AT lt_inob ASSIGNING FIELD-SYMBOL(<ls_inob>).
    " try to lock entry
    TEST-SEAM lock_seam.
      CALL FUNCTION 'ENQUEUE_ECKSSKXE'
        EXPORTING
          mode_ksskx     = 'E'
          mandt          = <ls_inob>-mandt
          klart          = <ls_inob>-klart
*         CLASS          =
          mafid          = 'O'
          objek          = <ls_inob>-objek
*         X_KLART        = ' '
*         X_CLASS        = ' '
*         X_MAFID        = ' '
*         X_OBJEK        = ' '
*         _SCOPE         = '2'
*         _WAIT          = ' '
*         _COLLECT       = ' '
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          OTHERS         = 3.
    END-TEST-SEAM.

    " if lock fails, log the failure and skip deleting this INOB
    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 1.
          MESSAGE e008(ngc_core_db) WITH <ls_inob>-klart <ls_inob>-objek INTO cl_upgba_logger=>mv_logmsg.
        WHEN 2 OR
             3.
          MESSAGE e009(ngc_core_db) WITH <ls_inob>-klart <ls_inob>-objek INTO cl_upgba_logger=>mv_logmsg.
      ENDCASE.
      cl_upgba_logger=>log->trace_single( ).

      " unlock locked entries of KSSK
      unlock_entries( ).

      " return from this point - conversion cannot be continued
      rv_lock_error = abap_true.
      RETURN.
    ENDIF.

    APPEND <ls_inob> TO mt_locked_inob.
  ENDLOOP.

ENDMETHOD.