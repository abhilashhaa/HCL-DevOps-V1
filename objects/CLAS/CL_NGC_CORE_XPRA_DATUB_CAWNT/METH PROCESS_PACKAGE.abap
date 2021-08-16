METHOD process_package.

  CONSTANTS:
    lc_max_date      TYPE datub VALUE '99991231'.

  DATA:
    lv_packsel_whr   TYPE string,
    lv_packno        TYPE i.

  DATA:
    lt_cawnt         TYPE STANDARD TABLE OF cawnt,
    lt_cawnt_update  TYPE STANDARD TABLE OF cawnt,
    lv_valid_to      TYPE datub,
    lv_atinn         TYPE atinn,
    lv_atzhl         TYPE atzhl,
    lv_spras         TYPE spras.

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
    CLEAR: lt_cawnt_update, lt_cawnt.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    "convert the package selection criteria into a WHERE clause
    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).
    SELECT * FROM cawnt CLIENT SPECIFIED
      WHERE (lv_packsel_whr)
      ORDER BY atinn, atzhl, spras, datuv DESCENDING
      INTO TABLE @lt_cawnt.
    LOOP AT lt_cawnt ASSIGNING FIELD-SYMBOL(<ls_cawnt>).
      " as the table is sorted by key fields and date from we have to
      " set the valid to field (datub) to '99991231' after each control break
      IF <ls_cawnt>-atinn NE lv_atinn
      OR <ls_cawnt>-atzhl NE lv_atzhl
      OR <ls_cawnt>-spras NE lv_spras.
        lv_valid_to = lc_max_date.
        lv_atinn    = <ls_cawnt>-atinn.
        lv_atzhl    = <ls_cawnt>-atzhl.
        lv_spras    = <ls_cawnt>-spras.
      ENDIF.

      " check if valid to field in cawn has been changed?
      " If we have new data records without change management we set the datub field to '99991231'
      " For records with change management we have to adjust each period
      IF <ls_cawnt>-datub NE lv_valid_to.
        <ls_cawnt>-datub = lv_valid_to.
        APPEND <ls_cawnt> TO lt_cawnt_update.
      ENDIF.

      " if change management is used the datub field of the predecessor record has to be adjusted
      " therefor we set variable to valid from date current record - 1
      lv_valid_to = <ls_cawnt>-datuv - 1.
    ENDLOOP.

    UPDATE cawnt CLIENT SPECIFIED FROM TABLE @lt_cawnt_update.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

  cl_upgba_logger=>log->close( ).

ENDMETHOD.