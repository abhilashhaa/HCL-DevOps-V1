  METHOD if_ngc_core_clf_db_update~ngc_core_clf_db_update.

    CALL FUNCTION 'NGC_CORE_CLF_DB_UPDATE' IN UPDATE TASK
      EXPORTING
        it_kssk_update = it_kssk_update
        it_inob_update = it_inob_update
        it_ausp_update = it_ausp_update.

  ENDMETHOD.