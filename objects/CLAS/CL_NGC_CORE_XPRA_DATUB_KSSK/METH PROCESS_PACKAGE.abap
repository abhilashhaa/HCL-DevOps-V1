METHOD process_package.

  CONSTANTS:
    lc_max_date     TYPE datub VALUE '99991231'.

  DATA:
    lv_packsel_whr  TYPE string,
    lv_packno       TYPE i.

  DATA:
    lt_kssk         TYPE STANDARD TABLE OF kssk,
    lt_kssk_update  TYPE STANDARD TABLE OF kssk,
    lv_new_valid_to TYPE datub VALUE lc_max_date,
    lv_valid_to     TYPE datub,
    lv_valid_from   TYPE datuv,
    lv_objek        TYPE cuobn,
    lv_mafid        TYPE klmaf,
    lv_klart        TYPE klassenart,
    lv_clint        TYPE clint.

  FIELD-SYMBOLS:
    <ls_packsel>    TYPE if_shdb_pfw_package_provider=>ts_packsel.

  cl_upgba_logger=>create( EXPORTING iv_logid     = mv_appl_name
                                     iv_logtype   = cl_upgba_logger=>gc_logtype_db
                                     iv_processid = cl_shdb_pfw=>ms_process_data-process_counter
                                     iv_skip_init = abap_true ).

  DATA(lv_packcnt) = lines( it_packsel ).
  MESSAGE i034(upgba) WITH 'Received' lv_packcnt 'packages to be processed' INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

  "we might get multiple packages into one worker process / this is auto tuned by PFW
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_kssk_update, lt_kssk.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    "convert the package selection criteria into a WHERE clause
    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).

    SELECT * FROM kssk CLIENT SPECIFIED
      WHERE (lv_packsel_whr)
      ORDER BY objek, mafid, klart, clint, datuv DESCENDING
      INTO TABLE @lt_kssk.
    LOOP AT lt_kssk ASSIGNING FIELD-SYMBOL(<ls_kssk>).
      " as the table is sorted by key fields and date from we have to
      " set the valid to field (datub) to '99991231' after each control break
      IF <ls_kssk>-objek NE lv_objek
      OR <ls_kssk>-mafid NE lv_mafid
      OR <ls_kssk>-klart NE lv_klart
      OR <ls_kssk>-clint NE lv_clint.
        lv_objek        = <ls_kssk>-objek.
        lv_mafid        = <ls_kssk>-mafid.
        lv_klart        = <ls_kssk>-klart.
        lv_clint        = <ls_kssk>-clint.
        lv_new_valid_to = lc_max_date.
      ELSEIF lv_valid_from = <ls_kssk>-datuv.
        lv_new_valid_to = lv_valid_to.
      ENDIF.

      lv_valid_from = <ls_kssk>-datuv.
      lv_valid_to   = lv_new_valid_to.

      " check if valid to field in cabnt has been changed?
      " If we have new data records without change management we set the datub field to '99991231'
      " For records with change management we have to adjust each period
      IF <ls_kssk>-datub NE lv_new_valid_to.
        <ls_kssk>-datub = lv_new_valid_to.
        APPEND <ls_kssk> TO lt_kssk_update.
      ENDIF.

      " if change management is used the datub field of the predecessor record has to be adjusted
      " therefor we set variable to valid from date current record - 1
      lv_new_valid_to = <ls_kssk>-datuv - 1.
    ENDLOOP.

    UPDATE kssk CLIENT SPECIFIED FROM TABLE @lt_kssk_update.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

  cl_upgba_logger=>log->close( ).

ENDMETHOD.