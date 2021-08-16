METHOD process_package.

  CONSTANTS:
    lc_max_date      TYPE datub VALUE '99991231'.

  DATA:
    lv_packsel_whr   TYPE string,
    lt_cabn          TYPE STANDARD TABLE OF cabn,
    lt_cabn_update   TYPE STANDARD TABLE OF cabn,
    lv_valid_to      TYPE datub,
    lv_atinn         TYPE atinn.

  FIELD-SYMBOLS:
    <ls_packsel>     TYPE if_shdb_pfw_package_provider=>ts_packsel.

  " now process the data in packages defined by package selection criteria
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_cabn_update, lt_cabn.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).
    SELECT * FROM cabn CLIENT SPECIFIED
      WHERE (lv_packsel_whr)
      ORDER BY atinn, datuv DESCENDING
      INTO TABLE @lt_cabn.
    LOOP AT lt_cabn ASSIGNING FIELD-SYMBOL(<ls_cabn>).
      " as the table is sorted by key fields and date from we have to
      " set the valid to field (datub) to '99991231' after each control break
      IF <ls_cabn>-atinn NE lv_atinn.
        lv_valid_to = lc_max_date.
        lv_atinn    = <ls_cabn>-atinn.
      ENDIF.

      " check if valid to field in table CABN has been changed?
      " If we have new data records without change management we set the datub field to '99991231'
      " For records with change management we have to adjust each period
      IF <ls_cabn>-datub NE lv_valid_to.
        <ls_cabn>-datub = lv_valid_to.
        APPEND <ls_cabn> TO lt_cabn_update.
      ENDIF.

      " if change management is used the datub field of the predecessor record has to be adjusted
      " therefor we set variable to valid from date current record - 1
      lv_valid_to = <ls_cabn>-datuv - 1.
    ENDLOOP.

    UPDATE cabn CLIENT SPECIFIED FROM TABLE @lt_cabn_update.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

ENDMETHOD.