  METHOD if_ngc_core_clf_db_update~clf_db_update.

    IF it_inob_insert_fm IS NOT INITIAL OR
       it_inob_delete_fm IS NOT INITIAL.

      " Update state is not possible with NGC API
      DATA:
        lt_inob_update_fm TYPE STANDARD TABLE OF rinob.

      CALL FUNCTION 'CUVI_UPDATE_INOB' IN UPDATE TASK
        TABLES
          entries        = it_inob_insert_fm
          delete_entries = it_inob_delete_fm
          update_entries = lt_inob_update_fm.
    ENDIF.

    IF it_kssk_delete_fm IS NOT INITIAL.
      CALL FUNCTION 'CLVF_VB_DELETE_CLASSIFICATION' IN UPDATE TASK
        TABLES
          deletetab = it_kssk_delete_fm.
    ENDIF.

    IF it_kssk_insert_fm IS NOT INITIAL OR
       it_kssk_delete_fm IS NOT INITIAL.
      CALL FUNCTION 'CLVF_VB_INSERT_CLASSIFICATION' IN UPDATE TASK
        EXPORTING
          called_from_cl = abap_true
        TABLES
          kssktab        = it_kssk_insert_fm
          ausptab        = it_ausp_fm
          i_mdcp         = it_clmdcp.
    ENDIF.

  ENDMETHOD.