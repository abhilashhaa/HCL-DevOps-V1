METHOD process_package.

  CONSTANTS:
    lc_max_date    TYPE datub VALUE '99991231'.

  DATA:
    lv_packsel_whr TYPE string,
    lv_packno      TYPE i.

  DATA:
    lt_cawn        TYPE STANDARD TABLE OF cawn,
    lt_cawn_update TYPE STANDARD TABLE OF cawn,
    lv_valid_to    TYPE datub,
    lv_atinn       TYPE atinn,
    lv_atzhl       TYPE atzhl.

  FIELD-SYMBOLS:
    <ls_packsel>     TYPE if_shdb_pfw_package_provider=>ts_packsel.

  cl_upgba_logger=>create( EXPORTING iv_logid     = mv_appl_name
                                     iv_logtype   = cl_upgba_logger=>gc_logtype_db
                                     iv_processid = cl_shdb_pfw=>ms_process_data-process_counter
                                     iv_skip_init = abap_true ).

  DATA(lv_packcnt) = lines( it_packsel ).
  MESSAGE i034(upgba) WITH 'Received' lv_packcnt 'packages to be processed' INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

  "we might get multiple packages into one worker process / this is auto tuned by PFW
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_cawn_update, lt_cawn.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    "convert the package selection criteria into a WHERE clause
    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).

    SELECT * FROM cawn CLIENT SPECIFIED
      WHERE (lv_packsel_whr)
      ORDER BY atinn, atzhl, datuv DESCENDING
      INTO TABLE @lt_cawn.
    LOOP AT lt_cawn ASSIGNING FIELD-SYMBOL(<ls_cawn>).
      " as the table is sorted by key fields and date from we have to
      " set the valid to field (datub) to '99991231' after each control break
      IF <ls_cawn>-atinn NE lv_atinn
      OR <ls_cawn>-atzhl NE lv_atzhl.
        lv_valid_to = lc_max_date.
        lv_atinn    = <ls_cawn>-atinn.
        lv_atzhl    = <ls_cawn>-atzhl.
      ENDIF.

      " check if valid to field in cawn has been changed?
      " If we have new data records without change management we set the datub field to '99991231'
      " For records with change management we have to adjust each period
      IF <ls_cawn>-datub NE lv_valid_to.
        <ls_cawn>-datub = lv_valid_to.
        APPEND <ls_cawn> TO lt_cawn_update.
      ENDIF.

      " if change management is used the datub field of the predecessor record has to be adjusted
      " therefor we set variable to valid from date current record - 1
      lv_valid_to = <ls_cawn>-datuv - 1.
    ENDLOOP.

    UPDATE cawn CLIENT SPECIFIED FROM TABLE @lt_cawn_update.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

  cl_upgba_logger=>log->close( ).

ENDMETHOD.