METHOD PROCESS_PACKAGE.

  CONSTANTS:
    lc_max_date      TYPE datub VALUE '99991231'.

  DATA:
    lv_packsel_whr   TYPE string,
    lt_cabnt         TYPE STANDARD TABLE OF cabnt,
    lt_cabnt_update  TYPE STANDARD TABLE OF cabnt,
    lv_valid_to      TYPE datub,
    lv_atinn         TYPE atinn,
    lv_spras         TYPE spras.

  FIELD-SYMBOLS:
    <ls_packsel>     TYPE if_shdb_pfw_package_provider=>ts_packsel.

   " Now process the data in packages defined by package selection criterias
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_cabnt_update, lt_cabnt.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).
    SELECT * FROM cabnt CLIENT SPECIFIED
      WHERE (lv_packsel_whr)
      ORDER BY atinn, spras, datuv DESCENDING
      INTO TABLE @lt_cabnt.
    LOOP AT lt_cabnt ASSIGNING FIELD-SYMBOL(<ls_cabnt>).
      " as the table is sorted by key fields and date from we have to
      " set the valid to field (datub) to '99991231' after each control break
      IF <ls_cabnt>-atinn NE lv_atinn
      OR <ls_cabnt>-spras NE lv_spras.
        lv_valid_to = lc_max_date.
        lv_atinn    = <ls_cabnt>-atinn.
        lv_spras    = <ls_cabnt>-spras.
      ENDIF.

      " check if valid to field in cabnt has been changed?
      " If we have new data records without change management we set the datub field to '99991231'
      " For records with change management we have to adjust each period
      IF <ls_cabnt>-datub NE lv_valid_to.
        <ls_cabnt>-datub = lv_valid_to.
        APPEND <ls_cabnt> TO lt_cabnt_update.
      ENDIF.

      " if change management is used the datub field of the predecessor record has to be adjusted
      " therefor we set variable to valid from date current record - 1
      lv_valid_to = <ls_cabnt>-datuv - 1.
    ENDLOOP.

    UPDATE cabnt CLIENT SPECIFIED FROM TABLE @lt_cabnt_update.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

ENDMETHOD.