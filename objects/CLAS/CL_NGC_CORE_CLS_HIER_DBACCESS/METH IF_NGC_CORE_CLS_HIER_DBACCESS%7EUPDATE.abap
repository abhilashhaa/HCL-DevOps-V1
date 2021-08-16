  METHOD if_ngc_core_cls_hier_dbaccess~update.
    CALL FUNCTION 'NGC_CORE_CLS_HIER_UPD_TASK' IN UPDATE TASK
      EXPORTING
        it_clhier_idx_insert = it_insert
        it_clhier_idx_update = it_update
        it_clhier_idx_delete = it_delete.
  ENDMETHOD.