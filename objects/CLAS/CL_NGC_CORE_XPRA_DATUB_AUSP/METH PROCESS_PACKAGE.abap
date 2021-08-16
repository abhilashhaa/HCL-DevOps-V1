METHOD process_package.

  CONSTANTS:
    lc_max_date      TYPE datub VALUE '99991231'.

  DATA:
    lv_packsel_whr   TYPE string,
    lv_packno        TYPE i.

  DATA:
    lt_ausp          TYPE STANDARD TABLE OF ausp,
    lt_ausp_update   TYPE STANDARD TABLE OF ausp,
    lv_new_valid_to  TYPE datub VALUE lc_max_date,
    lv_valid_to      TYPE datub,
    lv_valid_from    TYPE datuv,
    lv_objek         TYPE cuobn,
    lv_atinn         TYPE atinn,
    lv_atzhl         TYPE wzaehl,
    lv_mafid         TYPE klmaf,
    lv_klart         TYPE klassenart.

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
    CLEAR: lt_ausp_update, lt_ausp.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    "convert the package selection criteria into a WHERE clause
    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).

    SELECT * FROM ausp CLIENT SPECIFIED
      WHERE (lv_packsel_whr)
      ORDER BY objek, atinn, atzhl, mafid, klart, datuv DESCENDING
      INTO TABLE @lt_ausp.
    LOOP AT lt_ausp ASSIGNING FIELD-SYMBOL(<ls_ausp>).
      " as the table is sorted by key fields and date from we have to
      " set the valid to field (datub) to '99991231' after each control break
      IF <ls_ausp>-objek NE lv_objek
      OR <ls_ausp>-atinn NE lv_atinn
      OR <ls_ausp>-atzhl NE lv_atzhl
      OR <ls_ausp>-mafid NE lv_mafid
      OR <ls_ausp>-klart NE lv_klart.
        lv_objek        = <ls_ausp>-objek.
        lv_atinn        = <ls_ausp>-atinn.
        lv_atzhl        = <ls_ausp>-atzhl.
        lv_mafid        = <ls_ausp>-mafid.
        lv_klart        = <ls_ausp>-klart.
        lv_new_valid_to = lc_max_date.
      ELSEIF lv_valid_from EQ <ls_ausp>-datuv.
        lv_new_valid_to = lv_valid_to.
      ENDIF.

      lv_valid_from = <ls_ausp>-datuv.
      lv_valid_to   = lv_new_valid_to.

      " check if valid to field in ausp has been changed?
      " If we have new data records without change management we set the datub field to '99991231'
      " For records with change management we have to adjust each period
      IF <ls_ausp>-datub NE lv_new_valid_to.
        <ls_ausp>-datub = lv_new_valid_to.
        APPEND <ls_ausp> TO lt_ausp_update.
      ENDIF.

      " if change management is used the datub field of the predecessor record has to be adjusted
      " therefor we set variable to valid from date current record - 1
      lv_new_valid_to = <ls_ausp>-datuv - 1.
    ENDLOOP.

    UPDATE ausp CLIENT SPECIFIED FROM TABLE @lt_ausp_update.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

  cl_upgba_logger=>log->close( ).

ENDMETHOD.